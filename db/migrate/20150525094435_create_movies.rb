class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :imdb_code
      t.string :title
      t.integer :year
      t.integer :runtime
      t.string :mpa_rating
      t.attachment :poster

      t.timestamps
    end
  end
end
