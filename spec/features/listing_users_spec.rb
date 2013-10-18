require "spec_helper"

feature "Listing all users" do
  given!(:user_one) { FactoryGirl.create :user, email: 'userone@axample.com' }
  given!(:user_two) { FactoryGirl.create :user, email: 'usertwo@example.com' }

  scenario "listing all users on the index page" do
    visit users_path
    expect(page).to have_content user_one.email
    expect(page).to have_content user_two.email
  end
end
