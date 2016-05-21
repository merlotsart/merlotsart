FactoryGirl.define do
  factory :licensee_application do
    first_name 'Lee'
    last_name 'Licenseely'
    email 'lee@test.com'
    phone '555-555-1234'
    interested_locations 'Atlanta'
    comments 'A+ comment'
  end
end
