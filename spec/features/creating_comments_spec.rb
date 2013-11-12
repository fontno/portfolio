require "spec_helper"

feature "Creating Comments" do
  given!(:user) { FactoryGirl.create :user }
  given!(:post) { FactoryGirl.create :post, user: user }
  
  background do
    sign_in user
  end

  scenario "creating a comment on a post with valid info" do
    
  end
  
  
end

