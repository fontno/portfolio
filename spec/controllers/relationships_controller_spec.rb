require 'spec_helper'

describe RelationshipsController do

  let(:user) { FactoryGirl.create :user }
  let(:other_user) { FactoryGirl.create :user }

  before do
    sign_in(:user, user)
  end

  describe "Following" do
    
    it "will increment the relationship count" do
      expect do
        xhr :post, :create, relationship: { followed_id: other_user.id }
      end.to change(Relationship, :count).by(1)
    end

    it "will respond with success" do
      xhr :post, :create, relationship: { followed_id: other_user.id }
      expect(response).to be_success
    end
  end

  describe "Unfollowing" do
    
    before do
      user.follow!(other_user)
    end

    let(:relationship) { user.relationships.find_by(followed_id: other_user) }

    it "should decrement the Relationship count" do
      expect do
        xhr :delete, :destroy, id: relationship.id
      end.to change(Relationship, :count).by(-1)
    end

    it "should respond with success" do
      xhr :delete, :destroy, id: relationship.id
      expect(response).to be_success
    end
  end
end
