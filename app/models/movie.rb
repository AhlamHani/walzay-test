class Movie < ApplicationRecord
  has_and_belongs_to_many :locations
  has_and_belongs_to_many :actors
  has_many :reviews

  scope :with_average_rate, -> do
    joins(:reviews)
      .group(arel_table[:id])
      .select('movies.*, COALESCE(ROUND(AVG(reviews.rating), 1), NULL) as average_rate')
  end

  validates_presence_of :name, :created_at, :updated_at
end
