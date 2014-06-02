# original version autogenerated by Stepford: https://github.com/garysweaver/stepford

FactoryGirl.define do
  
  factory :user do
    sequence(:id)
    sequence(:email) do |n|; "person#{n}@example.com"; end
    password 'password'
    sign_in_count 0
  end
  
end