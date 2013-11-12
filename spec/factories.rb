# needed for fixture_file_upload
include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "email#{n}@example.com" }
    password "password"
    password_confirmation "password"
  end

  factory :post do
    text 'Post text'
    image { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'gold.jpeg')) }
    created_at 1.hour.ago
    user
  end
end
