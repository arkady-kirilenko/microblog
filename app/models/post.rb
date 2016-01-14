class Post < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_many :comments, :as => :commentable

  validates :title, presence: true, length: { minimum: 3, maximum: 144 }
  validates :body, presence: true, length: { minimum: 2 }
  #validate slug?
end
