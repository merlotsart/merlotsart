class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :public_event
  belongs_to :private_event
  has_many   :attendees
  accepts_nested_attributes_for :attendees

  validates_presence_of :name, :email, :phone

  obfuscate_id

  # The Order creation process:
  #
  #   1. Submitting event page form is a GET to orders#new with params:
  #        event_id
  #        available_slots (the qty selected)
  #        byob (the fee if selected)
  #        voucher_upgrade_fee (the fee if selected)
  #        wine_fee (the fee if selected)
  #        mimosas_fee (the fee if selected)
  #
  #   2. Orders#new:
  #        Finds the event via the event_id param and sets to @event
  #        Sets @quantity to the available_slots param cast to an integer
  #        Builds new Event order and sets to @order
  #        Generates a Braintree token and sets to @token
  #        Runs "#lock_slots" on @order with the @quantity parameter
  #        Builds Order attendees based on @quantity
  #        Renders the view
  #
  #        Notes: Why is #lock_slots ran before attendees are built? As I
  #        recall, slots are the same as attendees.
  #
  #   3. Orders#Create:
  #        Finds the event via the order_public_event_id param and sets to
  #          @event
  #        Builds new Order from order_params and sets to @order
  #        Sets @quantity to the order_quantity param cast to an integer
  #        Generates a Braintree token and sets it to @token
  #        Creates a new CheckPromo service object based on the
  #          order_discount_code param and sets it to the local variable promo
  #
  #        If promo is valid
  #          Runs #discount on promo and sets the return to the local variable
  #            discount.
  #        Otherwise
  #          Sets the local vaiable discount to 0
  #
  #        Sets the local variable total to the order_total param cast to an
  #          integer
  #
  #        If discount is greater than 0
  #          Sets @price to the total less the discount percent
  #        Otherwise
  #          Sets @price to the local variable total
  #
  #        # Here we are deciding if we need to run a transaction or if the
  #        order is free...
  #        if @price is greater than 0
  #          sets the local variable nonce to the payment_method_nonce param
  #          Processes the Braintree payment with:
  #              amount as @price,
  #              payment_method_nonce as the local variable nonce,
  #              options:
  #                submit_for_settlement as True
  #            ...and set to the local variable result
  #
  #          # Nested condintional - this one is for if we get a successful
  #          charge or if the payment fails...
  #          If the local variable result is not nil (we received a response)
  #            Run #save on @order
  #            Run #update_attributes with:
  #                public_event_id ad @event.id,
  #                total as @price,
  #                payment_id as result.transaction.id
  #              ...on @order
  #            Run #order_create on @order
  #            Create confirmation email with the @order and deliver now
  #            Redirect to the order#show page
  #          Otherwise
  #            Post a flash message that card was incorrect
  #            render the new page
  #
  #        # Here we continue the base conditional under the branch that the
  #        order is free...
  #        Otherwise the class is free
  #          Run #save on @order
  #          Create a confirmation email with the @order and deliver now
  #          Run #update_attributes with:
  #              public_event_id as @event.id,
  #              total as @price
  #            ...on @order
  #          Run #order_create on @order
  #          Redirect to the order#show page
  #
  #        Notes:
  #          1. Why is @order in the create action a Order.new but an
  #               @event.orders.new in the new action?
  #          2. Why is a new Braintree token generated in both the new and
  #               create actions?
  #          3. CheckPromo and discounting is ripe for refactor. The logic needs
  #               to be contained to one central location and the conditionals
  #               eliminated.
  #          4. Why is #order_create ran after we create and save an order?


  # Public - orders_controller.rb
  def lock_slots(qty)
    event_id = self.public_event_id
    qty.times { |num| available_slots(event_id)[num].update(locked_until: Time.now + 900) }
  end

  # Private - only used in current file.
  def locked_slots
    event = PublicEvent.find_by_id(self.public_event_id)
    slots = event.slots_unsold.where('locked_until > ?', Time.now)
  end

  # Private - only used in current file.
  def remove_slots
    event_id = self.public_event_id
    order_id = self.id
    qty = self.attendees.count
    qty.times { |num| self.locked_slots[num-1].destroy }
  end

  # Private - only used in current file.
  def return_refunded_slot
    self.attendees.update_all(order_id: nil)
  end

  # Not sure - presence of available slots attribute complicates lookup.
  def available_slots(event_id)
    event = PublicEvent.find_by_id(event_id)
    slots = event.slots_unsold.where('locked_until < ?', Time.now)
  end

  # Probably Private - Admin has a ton of refund actions but I believe they are
  # all independent of this method.
  def refund(payment_id)
    if payment_id != nil
      transaction = Braintree::Transaction.find(payment_id)
      if transaction.status == "settled"
        Braintree::Transaction.refund(payment_id)
      else
        Braintree::Transaction.void(payment_id)
      end
    end
  end

  # Public - used in admin/order.rb, admin/public_event.rb, and
  # orders_controller.rb.
  def cancel_order
    self.return_refunded_slot
    self.update_attributes(public_event_id: nil, private_event_id: nil, status: "Cancelled")
    self.refund(self.payment_id)
  end

  # Private - only used in current file.
  def update_attendees
    self.attendees.each do |attendee|
      attendee.update_attributes(public_event_id: self.public_event_id)
    end
  end

  # Public - used in orders_controller.rb
  def order_create
    self.update_attendees
    self.remove_slots
  end

  def sum_total(event, quantity, extras)
    #need to use the extras hash to build out the total for the order. Groupon
    #vouchers are the only key of extras that is the quantity, not the boolean.
    arr = []

    extras.each do |key, value|
      arr << key if value == 1
    end

  end
end
