class Post < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders
  ]
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_many :comments, :as => :commentable

  def slug_candidates
    [
      :name,
      [:name, :created_at]
    ]
end
