class Movie < ApplicationRecord
  has_many :locations
  has_many :actors
end
