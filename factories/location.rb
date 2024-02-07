FactoryBot.define do
  factory :location do
    sequence(:name) { |n| "Location #{n}" }
    created_at { Time.now }
    updated_at { Time.now }
  end
end