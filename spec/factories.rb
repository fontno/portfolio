FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "email#{n}@example.com" }
    password "password"
    password_confirmation "password"
  end

  factory :post do
    text 'Post text'
    created_at 1.hour.ago
    user
  end
end
