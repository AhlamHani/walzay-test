# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "User #{n}" }
    created_at { Time.now }
    updated_at { Time.now }
  end
end