require 'rails_helper'

RSpec.describe Movie, type: :model do
  # Validation tests
  # ensure columns title, created_at and updated_at are present before saving
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:created_at) }
  it { should validate_presence_of(:updated_at) }

  # Association tests
  # Ensure Movie model has a many-to-many relationship with the Location model
  describe 'associations' do
    let(:movie) { create(:movie) }
    let(:location) { create(:location, movies: [movie]) }

    it 'has and belongs to many locations' do
      expect(movie.locations).to include(location)
    end
  end

end