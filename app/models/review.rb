class Review < ApplicationRecord
  belongs_to :movie
  belongs_to :user

  validates :comment, :rating, :created_at, :updated_at, presence: true
  validates :comment, length: { maximum: 140 }

  enum rating: { very_poor: 1, poor: 2, fair: 3, good: 4, excellent: 5 }
end