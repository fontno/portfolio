class Api::V1::UsersController < Api::V1::ApiController
  respond_to :json

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    respond_with({ posts: @posts, username: @user.username, email: @user.email })
  end

end
