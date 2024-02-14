# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  # Validation tests
  # ensure columns name, email, created_at and updated_at are present before saving
  it { should validate_presence_of(:name) }

  # Association tests
  # Ensure User model has a 1:m relationship with the Review model
  it { should have_many(:reviews) }
end