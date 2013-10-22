require 'spec_helper'

describe User do

  before do
    @user = User.new(email: 'user@example.com', password: 'password', password_confirmation: 'password')
  end

  subject { @user } 

  it { should respond_to :posts }
  it { should respond_to :feed }

  describe "Post associations" do

    before do
      @user.save
    end

    let!(:post_one) { FactoryGirl.create :post, user: @user, created_at: 1.hour.ago }
    let!(:post_two) { FactoryGirl.create :post, user: @user, created_at: 1.day.ago }

    it "must be in descending order" do
      expect(@user.posts).to eq([post_two, post_one])
    end

    describe "feed" do
      let(:other_user) { FactoryGirl.create :user }
      let(:unfollowed_post) { FactoryGirl.create :post, user: other_user }

      it "includes user posts" do
        expect(@user.feed).to include(post_one)
        expect(@user.feed).to include(post_two)
      end

      it "excludes other users posts" do
        expect(@user.feed).not_to include(unfollowed_post)
      end
    end

  end
end
