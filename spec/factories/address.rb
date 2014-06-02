# original version autogenerated by Stepford: https://github.com/garysweaver/stepford

FactoryGirl.define do
  
  factory :address do
    sequence(:id)
    street_address1 Faker::Address.street_address
    street_address2 Faker::Address.secondary_address
    city  Faker::Address.city
    postal_code Faker::Address.postcode
  end
  
end