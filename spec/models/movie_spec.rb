require 'rails_helper'

RSpec.describe Movie, type: :model do
  it { should validate_presence_of(:name) }

  describe 'associations' do
    let(:movie) { create(:movie) }
    let(:location) { create(:location, movies: [movie]) }

    it 'has and belongs to many locations' do
      expect(movie.locations).to include(location)
    end
  end

end