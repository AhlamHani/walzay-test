require 'rails_helper'

RSpec.describe Actor, type: :model do
  # Validation tests
  # ensure columns name, created_at and updated_at are present before saving
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:created_at) }
  it { should validate_presence_of(:updated_at) }

  # Association tests
  # Ensure Actor model has a many-to-many relationship with the Movie model
  it { should have_and_belong_to_many(:movies) }
end
