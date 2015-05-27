require 'open-uri'

class YTSCrawler
  MOVIE_LIST_URL = 'https://yts.to/api/v2/list_movies.json'
  MOVIE_DETAIL_URL = 'https://yts.to/api/v2/movie_details.json?movie_id=15&with_images=true&with_cast=true'
  @queue = :yts

  def self.save_movie(m)
    puts "Saving movie #{m['title']} into database..."
    Movie.find_or_create_by(imdb_code: m['imdb_code']) do |movie|
      movie.title = m['title']
      movie.year = m['year']
      movie.runtime = m['runtime']
      movie.mpa_rating = m['mpa_rating']
      movie.poster = open(m['medium_cover_image'])
    end
  end

  def self.save_movies_from_uri(uri)
    puts "save_movies_from_uri #{uri}"
    JSON.load(open(uri))['data']['movies'].each do |movie|
      save_movie(movie)
    end
  end

  def self.perform
    puts 'Start YTS Crawler'
    # uri = URI::HTTP.build(host: MOVIE_LIST_URL, query: { page: 1 }.to_query).to_s
    uri = MOVIE_LIST_URL
    puts uri
    save_movies_from_uri(uri)
    puts 'YTS Crawler done!'
  end
end