class Movie < ApplicationRecord
  has_and_belongs_to_many :locations
  has_and_belongs_to_many :actors
  has_many :reviews

  scope :with_average_rate, -> do
    joins(:reviews)
      .group(arel_table[:id])
      .select('movies.*, COALESCE(ROUND(AVG(reviews.rating), 1), NULL) as average_rate')
  end

  validates_presence_of :name

  serialize :obdb, JSON

  @@pool = Concurrent::FixedThreadPool.new(10)

  class << self
    def pool
      @@pool
    end

    def wait_the_thread_pool!
      sleep(0.1) while pool.length >= pool.max_length
    end
  end

  def fetch_pool
    self.class.pool
  end

  def enqueue_fetch_poster
    return if omdb.present?

    self.class.wait_the_thread_pool!
    Concurrent::Future.execute(executor: self.class.pool) { fetch_movie_poster }
  end

  def fetch_movie_poster
    uri = URI("http://www.omdbapi.com/?apikey=a0263b48&t=#{CGI.escape(name)}")
    response = Net::HTTP.get(uri)
    data = JSON.parse(response)
    update!(omdb: data)
  end

  def poster_url
    omdb&.fetch('Poster')
  end

  def imdb_id
    omdb&.fetch('imdbID')
  end

  def imdb_url
    "https://www.imdb.com/title/#{imdb_id}" if imdb_id.present?
  end
end
