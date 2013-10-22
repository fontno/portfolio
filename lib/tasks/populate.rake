namespace :db do
  task populate: :environment do
    create_users
    create_posts
  end
end

def create_users
  User.create!(email: "brian@example.com", password: "password", password_confirmation: "password")
  100.times do
    email = Faker::Internet.email
    password = "password"
    User.create!(email: email, password: password, password_confirmation: password)
  end
end

def create_posts
  users = User.all
  50.times do
    users.each { |user| user.posts.create!(text: Faker::Lorem.paragraph) }
  end
end
