# spec/factories/actors.rb
FactoryBot.define do
  factory :actor do
    sequence(:name) { |n| "Actor #{n}" }
    created_at { Time.now }
    updated_at { Time.now }
  end
end