FactoryGirl.define do
  factory :attendee do
    name 'Anton Attendee'
    email 'anton@test.com'
    phone '555-555-1212'
    attended false
    discount_code ''
    locked_by 0
    locked_until '2022-01-01 00:00:01'
    order
    public_event
    private_event
  end
end
