require 'open-uri'

class YTSCrawler
  HOST = 'yts.to'
  MOVIE_LIST_PATH = '/api/v2/list_movies.json'
  MOVIE_DETAIL_PATH = '/api/v2/movie_details.json'
  @queue = :yts

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
    end
    m['genres'].each do |genre|
      g = Genre.find_or_create_by(name: genre)
      g.movies << movie unless g.movies.include?(movie)
    end
    language = Language.find_or_create_by(name: m['language'])
    language.movies << movie unless language.movies.include?(movie)
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