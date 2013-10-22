require "spec_helper"

feature "User feed" do
  given!(:user) { FactoryGirl.create :user }

  background do
    FactoryGirl.create :post, user: user, text: "post one", created_at: 1.day.ago
    FactoryGirl.create :post, user: user, text: "post two", created_at: 2.hour.ago
    sign_in user
  end

  scenario "User's posts are displayed as a feed" do
    expect(page).to have_content "post one"
    expect(page).to have_content "post two"
  end
end
