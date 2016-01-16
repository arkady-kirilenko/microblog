FactoryGirl.define do
  factory :tagging do
    post_id           { Fake::Number.number(2)}
    tag_id            { Fake::Number.number(2)}
  end



end
