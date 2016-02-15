class CheckPromo
  def initialize(code)
    @code = code
  end

  def promo
    Promo.find_by(code: @code)
  end

  def redemption_remaining
    (promo.number_of_uses - promo.number_of_times_used) > 0
  end

  def not_expired
    promo.expiration_date > Date.today
  end

  def valid?
    promo && redemption_remaining && not_expired
  end

  def discount
    promo.discount_percentage
  end
end
