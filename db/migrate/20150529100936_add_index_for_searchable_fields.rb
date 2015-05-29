class AddIndexForSearchableFields < ActiveRecord::Migration
  def up
    add_index :artists, [:name], name: 'artists_name_index'
    add_index :artists, [:slug], name: 'artists_slug_index'

    add_index :associations, [:kind], name: 'associations_kind_index'
    add_index :cast_memberships, [:role], name: 'cast_memberships_role_index'

    add_index :genres, [:name], name: 'genres_name_index'
    add_index :languages, [:name], name: 'languages_name_index'

    add_index :movie_ratings, [:imdb_rating], name: 'movie_ratings_imdb_index'
    add_index :movie_ratings, [:rt_critics_score, :rt_critics_rating, :rt_audience_score, :rt_audience_rating], name: 'movie_ratings_rt_index'

    add_index :movies, [:imdb_code], name: 'movies_imdb_code_index'
    add_index :movies, [:title], name: 'movies_title_index'
    add_index :movies, [:year], name: 'movies_year_index'
    add_index :movies, [:runtime], name: 'movies_runtime_index'
    add_index :movies, [:mpa_rating], name: 'movies_mpa_rating_index'
    add_index :movies, [:slug], name: 'movies_slug_index'
  end
end
