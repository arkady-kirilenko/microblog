require 'rails_helper'

RSpec.describe Comment, type: :model do

  it 'has a valid factory' do
    comment = create(:comment)
  end

  it 'has a valid author' do
    is_expected.to validate_presence_of(:author)
    is_expected.to validate_length_of(:author)
  end

  it 'has valid content' do
    is_expected.to validate_presence_of(:content)
    is_expected.to validate_length_of(:content)
  end

  it 'has a commentable object associated' do
    is_expected.to validate_presence_of(:commentable)
  end

end
