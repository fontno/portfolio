namespace :db do
  task populate: :environment do
    users
    posts
    relationships
  end
end

def users
  User.create!(username: "Brian", email: "fontenotbrian@gmail.com", password: "password", password_confirmation: "password")
  50.times do
    username = Faker::Name.name
    email = Faker::Internet.email
    password = "password"
    User.create!(username: username, email: email, password: password, password_confirmation: password)
  end
end

def posts
  #random_image = File.open(Dir.glob(File.join(Rails.root, 'lib', 'assets', 'random_images', '*')).sample)
  30.times do
    User.all.each do |user| 
      user_post = user.posts.build(text: Faker::Lorem.paragraph)
      user_post.image.store!(File.open(File.join(Rails.root, 'avatar.jpg')))
      user_post.save!
      #post_image = user.posts.create!(text: Faker::Lorem.paragraph)
      #post_image.image.store!(File.open(File.join(Rails.root, 'avatar.jpg')))
      #post_image.save
    end
  end
end

#def upload_images
  #Post.all.each do |post|
    #post.store!(File.open(File.join(Rails.root, 'avatar.jpg')))
    #post.save!
  #end
#end

def relationships
  users = User.all
  user = users.first
  followeds = users[2..50]
  followers = users[3..40]
  followeds.each { |followed| user.follow!(followed) }
  followers.each { |follower| follower.follow!(user) }
end
