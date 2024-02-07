class User < ApplicationRecord
  has_many :reviews

  validates_presence_of :name, :created_at, :updated_at
end
