FactoryGirl.define do
  factory :project do
    title               {Faker::Lorem.sentence}
    description         {Faker::Lorem.paragraph(3)}
    project_url         {Faker::Internet.url}
    github_url          {Faker::Internet.url}
    banner              {Faker::Company.logo}

    factory :invalid_project do
      title               ""
      description         ""
      project_url         ""
      github_url          ""
      banner              ""
    end

  end
end
