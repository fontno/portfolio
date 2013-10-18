require "spec_helper"

feature "Sign in" do
  given(:user) { FactoryGirl.create(:user) }

  scenario "Sign in with valid info" do
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"
    expect(page).to have_link "Logout"
    expect(page).to have_link "Profile"
  end

  scenario "Sign in with invalid info" do
    visit new_user_session_path
    fill_in "Email", with: " "
    fill_in "Password", with: " "
    click_button "Sign in"
    expect(page).to have_content "Invalid email or password"
    expect(page).to have_link "Login"
  end
end

