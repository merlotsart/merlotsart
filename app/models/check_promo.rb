class CheckPromo
  def initialize(discount_code, subtotal)
    @discount_code = discount_code
    @subtotal = subtotal.to_i
    @promo = Promo.find_by(code: discount_code)
  end

  def process_discount
    valid? ? apply_discount : @subtotal
  end

  def valid?
    @promo && redemption_remaining? && not_expired?
  end

  def redemption_remaining?
    (@promo.number_of_uses - @promo.number_of_times_used) > 0
  end

  def not_expired?
    @promo.expiration_date > Date.today
  end

  def apply_discount
    if @promo.discount_type == 'percentage'
      calculate_percentage_discount
    elsif @promo.discount_type == 'amount'
      calculate_amount_discount
    elsif @promo.discount_type == nil
      calculate_percentage_discount # Handle legacy discounts
    end
  end

  # This method is not 100% accurate to the concept of "percentage off". The
  # problem is with the coversion of an integer representation of what would be
  # a repleating percetage. Take a 33% discount for example:
  #
  #   33.to_f / 100  #=> .33
  #   10 * .33       #=> 3.30
  #   10 - 3.30      #=> 6.70, Not the 6.67 that would be expected.
  #
  # To correct this issue, we would need to convert to storing 3-place floats in
  # the db as the percentage_discount.
  def calculate_percentage_discount
    @percentage = (@subtotal - (@subtotal * (@promo.discount_percentage.to_f/100))).round(2)
  end

  def calculate_amount_discount
    @amount = @subtotal - @promo.discount_amount
  end

  def total
    if @promo.discount_type == 'percentage'
      "$" + sprintf("%.2f", @percentage ||= calculate_percentage_discount)
    elsif @promo.discount_type == 'amount'
      "$" + sprintf("%.2f", @amount ||= calculate_amount_discount)
    elsif @promo.discount_type == nil
      "$" + sprintf("%.2f", @percentage ||= calculate_percentage_discount)
    else
    end
  end

  def discount
    if @promo.discount_type == 'percentage'
      "#{@promo.discount_percentage}%"
    elsif @promo.discount_type == 'amount'
      "$" + sprintf("%.2f", @promo.discount_amount)
    elsif @promo.discount_type == nil
      "#{@promo.discount_percentage}%"
    else
    end
  end
end
