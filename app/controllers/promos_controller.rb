class PromosController < ApplicationController
  def show
    promo = CheckPromo.new(params[:promoCode], params[:subtotal])
    if request.xhr? && promo.valid?
      render :json => {
        valid: promo.valid?,
        processed: promo.process_discount,
        discount: promo.discount,
        total: promo.total
        # Need to either process the formatting to return based on promo type or
        # return the type for procesing in JS
      }
    else
      render :json => {
        valid: false,
        discount: 0
      }
    end
  end
end
