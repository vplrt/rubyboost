class Api::V1::RegistrationsController < Api::V1::BaseController
  def create
    user = User.new(user_params)

    if user.save
      render json: { success: true, auth_token: user.authentication_token }, status: 201
    else
      respond_with_error user
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
