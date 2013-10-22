require 'spec_helper'

describe Post do

  let(:user) { FactoryGirl.create :user }

  before do
    @post = user.posts.build(text: 'Post text')
  end

  describe "Association" do
    before do
      @post.user_id = nil
    end

    it "must belong to user" do
      expect(@post).not_to be_valid
    end
  end
    
  describe "text attribute" do

    before do
      @post.text = " " 
    end
    
    it "can not be blank" do
      expect(@post).not_to be_valid
    end
  end
end
