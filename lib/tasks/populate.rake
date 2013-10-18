namespace :db do
  task populate: :environment do
    create_users
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
