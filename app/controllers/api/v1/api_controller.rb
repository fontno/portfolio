# ApiController is the base controller in all of the api namespace
# Notice it does not inherit from ApplicationController, rather it stands in as the "ApplicationController" for the api
# All controllers in the api namespace must inherit from ApiController to ensure token authentication
#
class Api::V1::ApiController < ActionController::Base
  respond_to :json

  def require_token_authentication
    auth_token = request.headers["auth_token"]
    resource = User.find_by!(authentication_token: auth_token)

    if resource
      respond_with(status: 200)
    else
      respond_with(status: 401, json: { success: false, error: "Authentication token require" }
    end
  end

end
