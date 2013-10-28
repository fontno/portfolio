require 'spec_helper'

describe User do

  before do
    @user = User.new(email: 'user@example.com', password: 'password', password_confirmation: 'password')
  end

  subject { @user } 

  it { should respond_to :posts }
  it { should respond_to :feed }
  it { should respond_to :relationships }
  it { should respond_to :followeds }
  it { should respond_to :following? }
  it { should respond_to :follow! }
  it { should respond_to :reverse_relationships }
  it { should respond_to :followers }

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

  context "Following" do

    describe "Follow!" do

      let(:other_user) { FactoryGirl.create :user }

      before do
        @user.save
        @user.follow!(other_user)
      end

      it "must follow the user" do
        expect(@user).to be_following(other_user)
      end

      it "must incude the user in followeds" do
        expect(@user.followeds).to include(other_user)
      end
    end

    describe "Unfollow!" do
      
      let(:other_user) { FactoryGirl.create :user }

      before do
        @user.save
        @user.follow!(other_user)
        @user.unfollow!(other_user)
      end

      it "must not follow the user anymore" do
        expect(@user).not_to be_following(other_user)
      end

      it "must not include the user in followeds" do
        expect(@user.followeds).not_to include(other_user)
      end
    end

    describe "Followeds" do
      
      let(:other_user) { FactoryGirl.create :user }

      before do
        @user.save
        @user.follow!(other_user)
      end

      it "must include the user's followers" do
        expect(other_user.followers).to include(@user)
      end
    end
  end
end
