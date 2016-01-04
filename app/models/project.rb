class Project < ActiveRecord::Base
  has_attached_file :banner, styles: { banner:"1920x300>", medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :banner, content_type: /\Aimage\/.*\Z/
end
