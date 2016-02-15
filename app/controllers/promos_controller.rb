class PromosController < ApplicationController
  def show
    promo = CheckPromo.new(params[:promoCode])
    if request.xhr? && promo.valid?
      render :json => {
        valid: promo.valid?,
        discount: promo.discount
      }
    else
      render :json => {
        valid: false,
        discount: 0
      }
    end
  end
end
