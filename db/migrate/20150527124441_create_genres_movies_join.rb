class CreateGenresMoviesJoin < ActiveRecord::Migration
  def up
    create_table :genres_movies, id: false do |t|
      t.integer :genre_id
      t.integer :movie_id
    end
    add_index :genres_movies, [:genre_id, :movie_id], name: 'genres_movies_index'
  end

  def down
    drop_table :genres_movies
  end
end
