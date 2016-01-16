require 'rails_helper'

RSpec.describe Tag, type: :model do
  it "has a valid factory" do
    tag = build(:tag)
  end

  it "has valid content" do
      is_expected.to validate_presence_of(:content)
      is_expected.to validate_uniqueness_of(:content)
  end

end
