class Tag < ActiveRecord::Base
  has_many :taggings, dependent: :destroy
  has_many :posts, through: :taggings

  validates :content, presence: true, length: {minimum: 2, maximum: 30}
end
