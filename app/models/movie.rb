class Movie < ApplicationRecord
  include OmdbConcern

  has_and_belongs_to_many :locations
  has_and_belongs_to_many :actors
  has_many :reviews

  scope :with_average_rate, -> do
    left_outer_joins(:reviews)
      .group(arel_table[:id])
      .select('movies.*, ROUND(AVG(reviews.rating), 1) as average_rate')
  end

  validates_presence_of :name

  def poster_url
    omdb&.fetch('Poster')
  end

  def imdb_id
    omdb&.fetch('imdbID')
  end

  def duration
    omdb&.fetch('Runtime')
  end

  def imdb_url
    "https://www.imdb.com/title/#{imdb_id}" if imdb_id.present?
  end
end
