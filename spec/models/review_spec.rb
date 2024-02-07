# spec/models/review_spec.rb
require 'rails_helper'

RSpec.describe Review, type: :model do
  # Validation tests
  # ensure columns comment, rating, created_at and updated_at are present before saving
  it { should validate_presence_of(:comment) }
  it { should validate_presence_of(:rating) }
  it { should validate_presence_of(:created_at) }
  it { should validate_presence_of(:updated_at) }

  # Length validation test
  it { should validate_length_of(:comment).is_at_most(140) }

  # Association tests
  # Ensure Review model has a 1:m relationship with the Movie and User models
  it { should belong_to(:movie) }
  it { should belong_to(:user) }

  # Enum tests
  it do
    should define_enum_for(:rating)
      .with_values(very_poor: 1, poor: 2, fair: 3, good: 4, excellent: 5)
  end
end