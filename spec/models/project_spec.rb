require 'rails_helper'

RSpec.describe Project, type: :model do

  it 'has a valid factory' do
    project = create(:project)
  end

  it 'has a valid title' do
    is_expected.to validate_presence_of(:title)
    is_expected.to validate_length_of(:title)
    is_expected.to validate_uniqueness_of(:title)
  end

  it 'has a valid description' do
    is_expected.to validate_presence_of(:description)
    is_expected.to validate_length_of(:description)
  end

  it 'has a valid project link' do
    is_expected.to validate_length_of(:project_url)
  end

  it 'has a valid repository link' do
    is_expected.to validate_length_of(:github_url)
  end

  it 'has a valid banner image' do
    is_expected.to validate_presence_of(:banner)
  end


end
