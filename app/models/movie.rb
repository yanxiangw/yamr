class Movie < ActiveRecord::Base

  has_one :movie_rating
  has_and_belongs_to_many :genres
  has_and_belongs_to_many :languages

  has_attached_file :poster, default_url: '/images/:style/missing.png'
  validates_attachment_content_type :poster, content_type: /\Aimage\/.*\Z/
end
