class Promo < ActiveRecord::Base
  enum discount_type: [ :percentage, :amount ]
end
