  FactoryGirl.define do
  factory :post do
    title         { Faker::Lorem.sentence}
    body          { Faker::Lorem.paragraph(3)}

    factory :tagged_post do
      transient do
        tags_count 10
      end

      after(:create) do |post, evaluator|
        create_list(:tag, evaluator.tags_count, posts: [post])
      end
    end

    factory :invalid_post do
      title       ""
      body        ""
      tag
    end

  end

end
