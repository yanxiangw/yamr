class CastMembership < ActiveRecord::Base
  belongs_to :movie
  belongs_to :artist
end
