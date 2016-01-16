require 'rails_helper'

RSpec.describe Post, type: :model do
  it "has a valid factory" do
    user = build(:post)
  end

  it "has valid title" do
      is_expected.to validate_presence_of(:title)
      is_expected.to validate_length_of(:title)
  end

  it "has valid body" do
      is_expected.to validate_presence_of(:body)
      is_expected.to validate_length_of(:body)
  end

end
