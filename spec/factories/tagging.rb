FactoryGirl.define do
  factory :tagging do
    post_id           { Faker::Number.number(2)}
    tag_id            { Faker::Number.number(2)}
  end



end
