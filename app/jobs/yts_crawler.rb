require 'open-uri'

class YTSCrawler
  HOST = 'yts.to'
  MOVIE_LIST_PATH = '/api/v2/list_movies.json'
  MOVIE_DETAIL_PATH = '/api/v2/movie_details.json'
  @queue = :yts

  def self.save_ratings(m, movie)
    puts "\tSaving ratings for #{movie.title}"
    MovieRating.create(
      movie: movie,
      imdb_rating: m['rating'],
      rt_critics_score: m['rt_critics_score'],
      rt_critics_rating: m['rt_critics_rating'],
      rt_audience_score: m['rt_audience_score'],
      rt_audience_rating: m['rt_audience_rating'])
  end

  def self.save_artists(m, movie)
    puts "\tSaving artists for #{movie.title}"
    m['actors'].each do |actor|
      a = Artist.find_or_create_by(name: actor['name']) do |artist|
        artist.portrait = open(actor['medium_image'])
      end
      CastMembership.find_or_create_by(movie: movie, artist: a) do |cm|
        cm.role = actor['character_name']
      end
    end
    m['directors'].each do |director|
      d = Artist.find_or_create_by(name: director['name']) do |artist|
        artist.portrait = open(director['medium_image'])
      end
      Association.find_or_create_by(movie: movie, artist: d) do |assoc|
        assoc.director!
      end
    end
  end

  def self.save_genres(m, movie)
    puts "\tSaving genres for #{movie.title}"
    m['genres'].each do |genre|
      g = Genre.find_or_create_by(name: genre)
      g.movies << movie unless g.movies.include?(movie)
    end
  end

  def self.save_languages(m, movie)
    puts "\tSaving languages for #{movie.title}"
    language = Language.find_or_create_by(name: m['language'])
    language.movies << movie unless language.movies.include?(movie)
  end

  def self.save_movie(m)
    puts "Saving movie #{m['title']} into database..."
    movie = Movie.find_or_create_by(imdb_code: m['imdb_code']) do |movie|
      movie.title = m['title']
      movie.year = m['year']
      movie.runtime = m['runtime']
      movie.mpa_rating = m['mpa_rating']
      movie.poster = open(m['images']['large_cover_image'])
      movie.intro = m['description_intro']
      movie.plot = m['description_full']
      save_ratings(m, movie)
    end
    save_artists(m, movie)
    save_genres(m, movie)
    save_languages(m, movie)
  end

  def self.save_movies_from_uri(uri)
    JSON.load(open(uri))['data']['movies'].each do |movie|
      uri = URI::HTTPS.build(
        host: HOST,
        path: MOVIE_DETAIL_PATH,
        query: {
          movie_id: movie['id'],
          with_images: true,
          with_cast: true
          }.to_query
        ).to_s
      save_movie(JSON.load(open(uri))['data'])
    end
  end

  def self.perform
    puts 'Start YTS Crawler'
    uri = URI::HTTPS.build(
      host: HOST,
      path: MOVIE_LIST_PATH,
      query: {
        page: 1,
        limit: 10
        }.to_query
      ).to_s
    save_movies_from_uri(uri)
    puts 'YTS Crawler done!'
  end
end