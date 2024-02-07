FactoryBot.define do
  factory :movie do
    sequence(:name) { |n| "Movie #{n}" }
    description { "This is a description for Movie #{name}" }
    year { rand(1980..2022) }
    director { "Director #{name}" }
    created_at { Time.now }
    updated_at { Time.now }
  end
end