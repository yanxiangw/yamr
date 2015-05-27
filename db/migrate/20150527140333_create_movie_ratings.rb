class CreateMovieRatings < ActiveRecord::Migration
  def change
    create_table :movie_ratings do |t|
      t.references :movie, index: true
      t.float :imdb_rating
      t.integer :rt_critics_score
      t.string :rt_critics_rating
      t.integer :rt_audience_score
      t.string :rt_audience_rating

      t.timestamps
    end
  end
end
