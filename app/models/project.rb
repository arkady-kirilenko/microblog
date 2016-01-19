class Project < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  has_attached_file :banner, styles: { banner:"1920x300>", show:"1024x300#" }, default_url: "/images/:style/missing.png"

  validates_attachment_content_type :banner, content_type: /\Aimage\/.*\Z/
  validates :title, presence: true, length: { minimum: 3, maximum: 144}, uniqueness: true
  validates :description, presence: true, length: { minimum: 3}
  validates :banner, presence: true




end
