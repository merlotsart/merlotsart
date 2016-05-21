FactoryGirl.define do
  factory :public_event do
    status 'Pending'
    available_slots 10
    purchased_slots 1
    byob_fee 50
    name 'Primo Public Event'
    description 'A public description'
    price 100
    date '2020-01-01'
    start_time '12:00:00'
    end_time '13:00:00'
    address '1234 Main St.'
    city 'New York'
    state 'NY'
    zip '12345'
    live true
    artist
    experience
    location
    discount_code 1
    unlimited_wine 0
    unlimited_mimosas 0
    voucher_upgrade_fee 0
    groupon false
  end
end
