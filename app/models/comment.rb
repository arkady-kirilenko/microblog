class Comment < ActiveRecord::Base
  has_many :comments, :as => :commentable, dependent: :destroy
  belongs_to :commentable, :polymorphic => true

  validates :author, presence: true, length: { minimum: 3, maximum: 50}
  validates :content, presence: true, length: { minimum: 2, maximum: 500}
  validates :commentable, presence: true
end
