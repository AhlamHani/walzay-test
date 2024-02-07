class Review < ApplicationRecord
  belongs_to :movie
  belongs_to :user

  validates :name, :comment, :rating, presence: true
  validates :comment, length: { maximum: 140 }
  validates :rating, numericality: { only_integer: true }
  validates :rating, inclusion: { in: 1..5 }

  enum rating: { very_poor: 1, poor: 2, average: 3, good: 4, excellent: 5 }
end