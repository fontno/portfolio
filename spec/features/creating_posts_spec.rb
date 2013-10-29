require "spec_helper"

feature "Creating posts" do
  given!(:user) { FactoryGirl.create :user }

  background do
    sign_in user
  end

  scenario "with valid info renders the post" do
    fill_in "post_text", with: "sample post text"
    attach_file "post_image", 'spec/fixtures/gold.jpeg'
    click_button "Submit"
    expect(page).not_to have_content 'error'
    #expect(page).to have_content "sample post text"
  end
  
  scenario "with invalid info renders the form again" do
    fill_in "post_text", with: " "
    click_button "Submit"
    expect(page).to have_content 'error'
  end
end

