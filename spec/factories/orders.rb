FactoryGirl.define do
  factory :order do
    name 'Bob User'
    status 'Processed'
    email 'order_email@test.com'
    phone '555-555-1212'
    type ''
    total 123
    quantity 1
    payment_id ''
    discount_code ''
    groupon_code ''
    public_event
    private_event
    user
  end
end
