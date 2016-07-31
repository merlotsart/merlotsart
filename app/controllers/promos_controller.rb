class PromosController < ApplicationController
  def show
    promo = CheckPromo.new(params[:promoCode], params[:subtotal])
    if request.xhr? && promo.valid?
      render :json => {
        valid: promo.valid?,
        processed: promo.process_discount,
        discount: promo.discount,
        total: promo.total
      }
    else
      render :json => {
        valid: false,
        discount: 0
      }
    end
  end
end
