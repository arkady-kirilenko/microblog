FactoryGirl.define do

  factory :comment do
    association :commentable, factory: :post

    author            { Faker::Name.name}
    content           { Faker::Lorem.paragraph(3)}

    factory :invalid_comment do
      author          ""
      content         ""
    end

  end
end
