class Artist < ActiveRecord::Base
  extend FriendlyId
  
  has_many :cast_memberships
  has_many :associations
  has_many :movies, through: :cast_memberships

  has_attached_file :portrait, default_url: '/images/:style/missing.png'
  validates_attachment_content_type :portrait, content_type: /\Aimage\/.*\Z/

  friendly_id :name, use: :slugged
end
