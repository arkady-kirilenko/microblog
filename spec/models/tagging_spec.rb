require 'rails_helper'

RSpec.describe Tagging, type: :model do
  it 'has a valid factory' do
    tagging = create(:tagging)
  end

  it 'has a post' do
    is_expected.to validate_presence_of(:post_id)
  end

  it 'has a tag' do
    is_expected.to validate_presence_of(:tag_id)
  end
  
end
