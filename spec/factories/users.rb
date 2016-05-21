FactoryGirl.define do
  factory :user do
    name 'Eugene User'
    email 'eugene@test.com'
    phone '555-555-7777'
    password 'N0t_s3cur3'
    password_confirmation 'N0t_s3cur3'
  end
end
