FactoryGirl.define do
  factory :private_event do
    status 'Pending'
    available_slots 10
    purchased_slots 1
    name 'Private Event Perfection'
    event_type ''
    description 'A wonderful description'
    price 100
    date '2020-01-01'
    start_time '12:00:00'
    end_time '13:00:00'
    address '1234 Main St'
    city 'New York'
    state 'NY'
    zip '12345'
    occasion ''
    phone '555-555-1234'
    email 'private@test.com'
    how_hear 'A Birdie'
    employee_referral ''
    special_request 'A special request'
    artist
    experience
    location
  end
end
