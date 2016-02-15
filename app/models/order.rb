class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :public_event
  belongs_to :private_event
  has_many   :attendees
  accepts_nested_attributes_for :attendees

  validates_presence_of :name, :email, :phone

  obfuscate_id

  def lock_slots(qty)
    event_id = self.public_event_id
    qty.times { |num| available_slots(event_id)[num].update(locked_until: Time.now + 900) }
  end

  def locked_slots
    event = PublicEvent.find_by_id(self.public_event_id)
    slots = event.slots_unsold.where('locked_until > ?', Time.now)
  end

  def remove_slots
    event_id = self.public_event_id
    order_id = self.id
    qty = self.attendees.count
    qty.times { |num| self.locked_slots[num-1].destroy }
  end

  def return_refunded_slot
    self.attendees.update_all(order_id: nil)
  end

  def available_slots(event_id)
    event = PublicEvent.find_by_id(event_id)
    slots = event.slots_unsold.where('locked_until < ?', Time.now)
  end

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

  def cancel_order
    self.return_refunded_slot
    self.update_attributes(public_event_id: nil, private_event_id: nil, status: "Cancelled")
    self.refund(self.payment_id)
  end

  def update_attendees
    self.attendees.each do |attendee|
      attendee.update_attributes(public_event_id: self.public_event_id)
    end
  end

  def order_create
    self.update_attendees
    self.remove_slots
  end
end