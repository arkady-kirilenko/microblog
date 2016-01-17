FactoryGirl.define do
  factory :post do
    title         { Faker::Lorem.sentence}
    body          { Faker::Lorem.paragraph(3)}

    #association :tagging, strategy: :build

    factory :tagged_post do
      transient do
        tag { create :tag}
      end

      after :create do |post, evaluator|
        post.tags << evaluator.tag
        post.save
      end
    end

    factory :invalid_post do
      title       ""
      body        ""
      tag
    end

  end

end
