# frozen_string_literal: true

class Actor < ApplicationRecord
  has_and_belongs_to_many :movies

  searchkick

  scope :by_name, ->(name) { where(arel_table[:name].matches("%#{name}%")) }

  validates_presence_of :name
end
