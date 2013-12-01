# Clients will submit email and password params to set up token authentication on the first request.
# All other requests will use the auth_token header to authenticate

class Api::V1::AuthenticationTokensController < Api::V1::ApiController
  respond_to :json

  skip_before_action :require_token_authentication!
  before_action :validate_login_params

  def authenticate
    user = User.find_for_database_authentication(email: params[:email])
    return invalid_email unless user

    if user.valid_password?(params[:password])
      sign_in(user, store: false)
      render status: 200, json: { email: user.email, auth_token: user.authentication_token }
    else
      invalid_credentials
    end
  end

  private

    def validate_login_params
      if params[:email].blank? || params[:password].blank?
        render status: 401, json: { success: false, error: "Email/Password can not be blank" }
        return false
      end
    end

    def invalid_credentials
      render status: 401, json: { success: false, error: "Invalid Email/Password" }
      return false
    end

    def invalid_email
      render status: 401, json: { success: false, error: "Invalid email" }
      return false
    end

end
