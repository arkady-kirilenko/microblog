FactoryGirl.define do
  factory :admin do
    email                         { Faker::Internet.email}
    password                      "password"
    password_confirmation         "password"
    approved                      true 
  end
end
