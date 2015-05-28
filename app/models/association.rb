class Association < ActiveRecord::Base
  belongs_to :movie
  belongs_to :artist

  enum kind: [:director, :writer]
end
