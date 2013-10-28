class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:following, :followers]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end
  
  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followeds
    render 'all_relationships'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers
    render 'all_relationships'
  end
end
