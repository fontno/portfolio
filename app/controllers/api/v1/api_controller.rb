# ApiController is the base controller in all of the api namespace
# Notice it does not inherit from ApplicationController, rather it stands in as the "ApplicationController" for the api
# All controllers in the api namespace must inherit from ApiController to ensure token authentication

class Api::V1::ApiController < ActionController::Base
  respond_to :json

  private

  def require_token_authentication!
    authenticate_or_request_with_http_token do |token, options|
      User.exists?(authentication_token: token)
    end
  end
end
