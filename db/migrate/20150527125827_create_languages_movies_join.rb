class CreateLanguagesMoviesJoin < ActiveRecord::Migration
  def up
    create_table :languages_movies, id: false do |t|
      t.integer :language_id
      t.integer :movie_id
    end
    add_index :languages_movies, [:language_id, :movie_id], name: 'languages_movies_index'
  end

  def down
    drop_table :languages_movies
  end
end
