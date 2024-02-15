class User < ApplicationRecord
  has_many :reviews

  searchkick

  validates_presence_of :name
end
