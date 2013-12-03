#class Api::V1::RegistrationsController < Devise::RegistrationsController
class Api::V1::RegistrationsController < Api::V1::ApiController
  respond_to :json

  skip_before_action :require_token_authentication!

  def create
    user = User.new(registration_params)
    if user.save
      render status: 200, json: { email: user.email, auth_token: user.authentication_token }
    else
      render status: 400, json: { error: "Failed to register" }
    end
  end

  private

    def registration_params
      params.permit(:email, :password, :password_confirmation)
    end
end
