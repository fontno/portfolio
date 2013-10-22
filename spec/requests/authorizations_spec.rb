require 'spec_helper'

describe "Authorizations" do

  context "Users not signed in" do
    
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
  end
end
