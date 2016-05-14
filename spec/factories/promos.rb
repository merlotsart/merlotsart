FactoryGirl.define do
  factory :promo do
    email "promo_email@test.com"
    code "test_code"
    discount_percentage 50
    number_of_uses 10
    number_of_times_used 0
    expiration_date '2020-01-01'
  end
end
