# spec/models/review_spec.rb
require 'rails_helper'

RSpec.describe Review, type: :model do
  it { should validate_presence_of(:comment) }
  it { should validate_presence_of(:rating) }

  it { should validate_length_of(:comment).is_at_most(140) }

  it { should belong_to(:movie) }
  it { should belong_to(:user) }

  it do
    should define_enum_for(:rating)
      .with_values(very_poor: 1, poor: 2, fair: 3, good: 4, excellent: 5)
  end
end