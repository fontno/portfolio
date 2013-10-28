feature "Relationships" do
  
  given!(:user) { FactoryGirl.create :user }
  given!(:other_user) { FactoryGirl.create :user }

  context "Following" do

    background do
      sign_in user
    end

    scenario "following another user" do
      visit user_path(other_user)
      click_button "Follow"
      expect(page).to have_button "Unfollow"
    end
  end

  context "Unfollowing" do

    background do
      sign_in user
      user.follow!(other_user)
    end

    scenario "unfollowing another user" do
      visit user_path(other_user)
      click_button "Unfollow"
      expect(page).to have_button "Follow"
    end
  end
end

