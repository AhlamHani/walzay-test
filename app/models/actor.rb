class Actor < ApplicationRecord
  has_and_belongs_to_many :movies

  scope :by_name, ->(name) { where(arel_table[:name].matches("%#{name}%")) }
end
