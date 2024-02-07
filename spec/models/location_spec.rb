require 'rails_helper'

RSpec.describe Location, type: :model do
  # Validation tests
  # ensure columns name, created_at and updated_at are present before saving
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:created_at) }
  it { should validate_presence_of(:updated_at) }

  # Association tests
  describe 'associations' do
    let(:movie) { create(:movie) }
    let(:location) { create(:location, movies: [movie]) }

    it 'has and belongs to many movies' do
      expect(location.movies).to include(movie)
    end
  end
end