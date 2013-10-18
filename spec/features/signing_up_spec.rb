require "spec_helper"

feature "User sign up" do
  
  scenario "Sign up with valid info" do
    visit new_user_registration_path
    fill_in "Email", with: "fontno@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    expect { click_button "Sign up" }.to change(User, :count).by 1
  end

  scenario "Sign up with invalid info" do
    visit new_user_registration_path
    fill_in "Email", with: " "
    fill_in "Password", with: " "
    fill_in "Password confirmation", with: " "
    expect { click_button "Sign up" }.to change(User, :count).by 0
    expect(page).to have_content("errors")
  end
end

