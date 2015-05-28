class Movie < ActiveRecord::Base
  extend FriendlyId

  has_one :movie_rating
  has_and_belongs_to_many :genres
  has_and_belongs_to_many :languages
  has_many :cast_memberships
  has_many :associations
  has_many :casts, through: :cast_memberships, class_name: 'Artist', source: :artist

  has_attached_file :poster, default_url: '/images/:style/missing.png'
  validates_attachment_content_type :poster, content_type: /\Aimage\/.*\Z/

  friendly_id :slug_candidates, use: :slugged

  def slug_candidates
    [
      :title,
      [:title, :year]
    ]
  end
end
