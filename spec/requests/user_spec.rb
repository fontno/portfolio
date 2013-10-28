require "spec_helper"

describe "User" do
  
  context "Relationships" do
    
    let(:user) { FactoryGirl.create :user }
    let(:other_user) { FactoryGirl.create :user }
    
    describe "Following" do

      it "will increment the followed user count" do
        expect do
          user.follow!(other_user)
        end.to change(user.followeds, :count).by(1)
      end

      it "will increment the other user's follower count" do
        expect do
          user.follow!(other_user)
        end.to change(other_user.followers, :count).by(1)
      end
    end
    describe "Unfollowing" do

      before do
        user.follow!(other_user)
      end

      it "will decrement the followed user count" do
        expect do
          user.unfollow!(other_user)
        end.to change(user.followeds, :count).by(-1)
      end

      it "will increment the other user's follower count" do
        expect do
          user.unfollow!(other_user)
        end.to change(other_user.followers, :count).by(-1)
      end
    end
  end
end
