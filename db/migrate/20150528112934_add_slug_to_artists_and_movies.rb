class AddSlugToArtistsAndMovies < ActiveRecord::Migration
  def change
    add_column :artists, :slug, :string, unique: true
    add_column :movies, :slug, :string, unique: true
  end
end
