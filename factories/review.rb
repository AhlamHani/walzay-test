FactoryBot.define do
  factory :review do
    comment { "This is a sample review comment." }
    rating { rand(1..5) }
    movie
    user
    created_at { Time.now }
    updated_at { Time.now }
  end
end