class AddRemoteUrlForMoviesAndArtists < ActiveRecord::Migration
  def up
    add_column :artists, :portrait_url, :string
    add_column :movies, :poster_url, :string
  end

  def down
    remove_column :artists, :portrait_url
    remove_column :movies, :poster_url
  end
end
