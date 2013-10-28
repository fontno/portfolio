namespace :db do
  task populate: :environment do
    users
    posts
    relationships
  end
end

def users
  User.create!(email: "brian@example.com", password: "password", password_confirmation: "password")
  50.times do
    email = Faker::Internet.email
    password = "password"
    User.create!(email: email, password: password, password_confirmation: password)
  end
end

def posts
  users = User.all
  50.times do
    users.each do |user| 
      user.posts.create!(text: Faker::Lorem.paragraph)
    end
  end
end

def relationships
  users = User.all
  user = users.first
  followeds = users[2..50]
  followers = users[3..40]
  followeds.each { |followed| user.follow!(followed) }
  followers.each { |follower| follower.follow!(user) }
end
