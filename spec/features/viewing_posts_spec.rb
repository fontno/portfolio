require "spec_helper"

feature "Viewing Posts" do
  given!(:user) { FactoryGirl.create :user }
  given!(:post) { FactoryGirl.create :post, user: user }

  background do
    sign_in user
  end
  
  scenario "viewing an individual post from the user profile page" do
    click_link "Profile"
    click_link "Thumb gold" ## image identified by alt tag
    expect(page).to have_content post.image
    expect(page).to have_content post.text
    expect(page).to have_content post.user.email
  end
  
  scenario "viewing an individual post from the post feed on the home page" do
    click_link "Thumb gold" ## image identified by alt tag
    expect(page).to have_content post.image
    expect(page).to have_content post.text
    expect(page).to have_content post.user.email
  end
end
