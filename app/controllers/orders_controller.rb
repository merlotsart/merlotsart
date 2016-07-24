class OrdersController < ApplicationController
  def new
    @event    = PublicEvent.find_by_id(params[:event_id])
    @quantity = params[:available_slots].to_i
    @order    = @event.orders.new()
    @token    = Braintree::ClientToken.generate
    @order.lock_slots(@quantity)
    @quantity.times { @order.attendees.build }
  end

  def create
    @event        = PublicEvent.find_by_id(params[:order][:public_event_id])
    @order        = Order.new(order_params)
    @quantity     = params[:order][:quantity].to_i
    @token        = Braintree::ClientToken.generate
    discount_code = params[:order][:discount_code]
    subtotal      = params[:order][:total].to_i
    total         = CheckPromo.new(discount_code, subtotal).process_discount

    # old code - pending delete
    # if promo.valid?
    #   discount = promo.discount
    # else
    #   discount = 0
    # end

    # if discount > 0
    #   @price = (total - (total * (discount.to_f/100))).round(2)
    # else
    #   @price = total
    # end

    if total > 0
      nonce     = params[:payment_method_nonce]
      result    = Braintree::Transaction.sale(
        amount: total,
        payment_method_nonce: nonce,
          options: {
            submit_for_settlement: true
          }
        )
      if result.transaction != nil
        @order.save
        @order.update_attributes(public_event_id: @event.id, total: total, payment_id: result.transaction.id)
        @order.order_create
        UserMailer.confirmation(@order).deliver_now
        redirect_to order_path(@order)
      else
        flash[:notice] = "Sorry the card information was not correct, please try again."
        render :new
      end
    else
      @order.save
      UserMailer.confirmation(@order).deliver_now
      @order.update_attributes(public_event_id: @event.id, total: total)
      @order.order_create
      redirect_to order_path(@order)
    end
  end

  def show
    @order     = Order.find(params[:id])
    @attendees = @order.attendees
  end

  def cancel
    @order = Order.find(params[:id])
    @order.cancel_order
    redirect_to order_path(@order)
  end

  private

  def order_params
    params.require(:order).permit(:name, :phone, :email, :public_event_id, :discount_code, :groupon_code, :quantity, :total, attendees_attributes: [:id, :name, :phone, :email, :discount_code])
  end
end
