require 'spec_helper'

describe Relationship do

  let(:follower) { FactoryGirl.create :user }
  let(:followed) { FactoryGirl.create :user }
  let(:relationship) { follower.relationships.build(followed_id: followed.id) }

  subject { relationship }

  describe "Follower" do
    it { should respond_to :follower }
    it { should respond_to :followed }

    it "must follow the correct user" do
      expect(relationship.follower).to eq follower
    end

    it "must have the correct user being followed" do
      expect(relationship.followed).to eq followed
    end
  end

  describe "Followed id" do
    before do
      relationship.followed_id = nil
    end

    it "can not be blank" do
      expect(relationship).not_to be_valid
    end
  end

  describe "Follower id" do
    before do
      relationship.follower_id = nil
    end

    it "can not be blank" do
      expect(relationship).not_to be_valid
    end
  end
end
