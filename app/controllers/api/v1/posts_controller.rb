class Api::V1::PostsController < Api::V1::ApiController
  respond_to :json

  before_action :require_token_authentication!

  def index
    @posts = Post.limit(20);
    respond_with({ posts: @posts })
  end

  #TODO: request.header['Authorization']
end
