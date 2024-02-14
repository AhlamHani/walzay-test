require 'rails_helper'

RSpec.describe Location, type: :model do
  it { should validate_presence_of(:name) }

  describe 'associations' do
    let(:movie) { create(:movie) }
    let(:location) { create(:location, movies: [movie]) }

    it 'has and belongs to many movies' do
      expect(location.movies).to include(movie)
    end
  end
end