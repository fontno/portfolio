require 'spec_helper'

describe "Authorizations" do

  context "Users not signed in" do

    describe "Users controller" do

      let(:user) { FactoryGirl.create :user }

      describe "can not access the following page" do
        before { get following_user_path(user) }
        specify { expect(response).to redirect_to(new_user_session_path) }
      end

      describe "can not access the followers page" do
        before { get followers_user_path(user) }
        specify { expect(response).to redirect_to(new_user_session_path) }
      end
    end
    
    describe "Posts controller" do

      let!(:user) { FactoryGirl.create :user }
      
      describe "can not access the create action" do
        before { post posts_path }
        specify { expect(response).to redirect_to(new_user_session_path) }
      end

      describe "can not access the create action" do
        before { delete post_path(FactoryGirl.create(:post)) }
        specify { expect(response).to redirect_to(new_user_session_path) }
      end
    end

    describe "Relationships controller" do
      
      let!(:user) { FactoryGirl.create :user }

      describe "can not access the create action" do
        before { post relationships_path }
        specify { expect(response).to redirect_to(new_user_session_path) }
      end

      describe "can not access the destroy action" do
        before { delete relationship_path(1) }
        specify { expect(response).to redirect_to(new_user_session_path) }
      end
    end

  end
end
