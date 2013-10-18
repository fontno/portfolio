require "spec_helper"

feature "User Profile" do
  given(:user) { FactoryGirl.create :user }
  
  background do
    sign_in user
  end

  scenario "viewing the user's profile page" do
    visit user_path(user)
    expect(page).to have_content user.email
  end
end
