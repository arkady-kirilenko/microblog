FactoryGirl.define do
  factory :tag do
    content { Faker::Lorem.characters(10)}
  end
end
