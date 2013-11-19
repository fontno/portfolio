# Clients will submit email and password params to set up token authentication on the first request.
# All other requests will use the auth_token header to authenticate
# 
class Api::V1::AuthenticationTokensController < Api::V1::ApiController
  respond_to :json

  #skip_before_action :authenticate_user!
  skip_before_action :require_token_authentication!
  before_action :validate_login_params

  def authenticate
    # look up email
    resource = User.find_for_database_authentication(email: params[:email])
    return invalid_email unless resource
    
    # look up password if email was found
    # if password is correct then generate a token
      if resource.valid_password?(params[:password])
        sign_in(:user, resource)
        resource.ensure_authentication_token!
        respond_with(status: 200, json: { success: true, email: resource.email, auth_token: resource.authentication_token } )
      else
        invalid_password
      end

  end

  private

    def validate_login_params
      if params[:email].blank? || params[:password].blank?
        respond_with(status: 401, json: { success: false, error: "Email/Password can not be blank" } )
        return false
      end
    end

    def invalid_email
      respond_with(status: 401, json: { success: false, error: "Invalid email" } )
      return false
    end

    def invalid_password
      respond_with(status: 401, json: { success: false, error: "Invalid password" } )
      return false
    end

end
