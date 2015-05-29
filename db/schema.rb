# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150529100936) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artists", force: true do |t|
    t.string   "name"
    t.string   "portrait_file_name"
    t.string   "portrait_content_type"
    t.integer  "portrait_file_size"
    t.datetime "portrait_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.string   "portrait_url"
  end

  add_index "artists", ["name"], name: "artists_name_index", using: :btree
  add_index "artists", ["slug"], name: "artists_slug_index", using: :btree

  create_table "associations", force: true do |t|
    t.integer  "movie_id"
    t.integer  "artist_id"
    t.integer  "kind"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "associations", ["artist_id"], name: "index_associations_on_artist_id", using: :btree
  add_index "associations", ["kind"], name: "associations_kind_index", using: :btree
  add_index "associations", ["movie_id"], name: "index_associations_on_movie_id", using: :btree

  create_table "cast_memberships", force: true do |t|
    t.integer  "movie_id"
    t.integer  "artist_id"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cast_memberships", ["artist_id"], name: "index_cast_memberships_on_artist_id", using: :btree
  add_index "cast_memberships", ["movie_id"], name: "index_cast_memberships_on_movie_id", using: :btree
  add_index "cast_memberships", ["role"], name: "cast_memberships_role_index", using: :btree

  create_table "genres", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "genres", ["name"], name: "genres_name_index", using: :btree

  create_table "genres_movies", id: false, force: true do |t|
    t.integer "genre_id"
    t.integer "movie_id"
  end

  add_index "genres_movies", ["genre_id", "movie_id"], name: "genres_movies_index", using: :btree

  create_table "languages", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "languages", ["name"], name: "languages_name_index", using: :btree

  create_table "languages_movies", id: false, force: true do |t|
    t.integer "language_id"
    t.integer "movie_id"
  end

  add_index "languages_movies", ["language_id", "movie_id"], name: "languages_movies_index", using: :btree

  create_table "movie_ratings", force: true do |t|
    t.integer  "movie_id"
    t.float    "imdb_rating"
    t.integer  "rt_critics_score"
    t.string   "rt_critics_rating"
    t.integer  "rt_audience_score"
    t.string   "rt_audience_rating"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "movie_ratings", ["imdb_rating"], name: "movie_ratings_imdb_index", using: :btree
  add_index "movie_ratings", ["movie_id"], name: "index_movie_ratings_on_movie_id", using: :btree
  add_index "movie_ratings", ["rt_critics_score", "rt_critics_rating", "rt_audience_score", "rt_audience_rating"], name: "movie_ratings_rt_index", using: :btree

  create_table "movies", force: true do |t|
    t.string   "imdb_code"
    t.string   "title"
    t.integer  "year"
    t.integer  "runtime"
    t.string   "mpa_rating"
    t.string   "poster_file_name"
    t.string   "poster_content_type"
    t.integer  "poster_file_size"
    t.datetime "poster_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "intro"
    t.text     "plot"
    t.string   "slug"
    t.string   "poster_url"
    t.string   "youtube_video_id"
  end

  add_index "movies", ["imdb_code"], name: "movies_imdb_code_index", using: :btree
  add_index "movies", ["mpa_rating"], name: "movies_mpa_rating_index", using: :btree
  add_index "movies", ["runtime"], name: "movies_runtime_index", using: :btree
  add_index "movies", ["slug"], name: "movies_slug_index", using: :btree
  add_index "movies", ["title"], name: "movies_title_index", using: :btree
  add_index "movies", ["year"], name: "movies_year_index", using: :btree

end
