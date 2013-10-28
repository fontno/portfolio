require "spec_helper"

feature "User Profile" do
  given!(:user) { FactoryGirl.create :user }
  given!(:other_user) { FactoryGirl.create :user }
  given!(:post_one) { FactoryGirl.create :post, user: user, text: "post one" }
  given!(:post_two) { FactoryGirl.create :post, user: user, text: "post two" }
  
  background do
    sign_in user
    other_user.follow!(user)
  end

  scenario "viewing the user's profile page" do
    visit user_path(user)
    expect(page).to have_content user.email
  end

  scenario "listing all user posts on the profile page" do
    visit user_path(user)
    expect(page).to have_content post_one.text
    expect(page).to have_content post_two.text
  end

  scenario "showing a user's followeds and followers" do
    visit user_path(user)
    expect(page).to have_link("0 following", href: following_user_path(user))
    expect(page).to have_link("1 followers", href: followers_user_path(user))
  end
  
end
