class PostsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = current_user.posts.build(posts_params)
    if @post.save
      redirect_to root_url
    else
      @feed_items = []
      render 'pages/home'
    end
  end

  def destroy
  end

  private
  def posts_params
    params.require('post').permit(:text, :image)
  end
end
