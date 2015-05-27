class Movie < ActiveRecord::Base
  has_attached_file :poster, default_url: '/images/:style/missing.png'
  validates_attachment_content_type :poster, content_type: /\Aimage\/.*\Z/
end
