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

    if total > 0

      nonce  = params[:payment_method_nonce]
      result = ProcessBilling.process(nonce, total)

      if result.success?
        persist_order(total, result.transaction.id)
      else
        flash.now[:error] = "Sorry the card information was not correct, please try again."
        render :new
      end

    else
      persist_order(total)
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

  def persist_order(total, transaction_id = nil)
    @order.save
    @order.update_attributes(public_event_id: @event.id, total: total, payment_id: transaction_id)
    @order.order_create
    UserMailer.confirmation(@order).deliver_now
    redirect_to order_path(@order)
  end
end
