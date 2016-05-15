FactoryGirl.define do
  factory :public_event do
    status ''
    available_slots 10
    purchased_slots 1
    byob_fee 50
    name ''
    description ''
    price 100
    date '2020-01-01'
    start_time Time.now
    end_time Time.now + 2.hours
    address '1234 Main St.'
    city 'New York'
    state 'NY'
    zip '12345'
    live true
    artist
    experience
    location
    image_file_name 'image'
    image_content_type 'jpg'
    image_file_size 1
    image_updated_at DateTime.now
    discount_code 1
    unlimited_wine 0
    unlimited_mimosas 0
    voucher_upgrade_fee 0
    groupon false
  end
end
