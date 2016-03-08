class Users::ProfileController < Users::BaseController
  def edit
  end

  def update
    if current_user.update(user_params)
      sign_in current_user, bypass: true
      redirect_to dashboard_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, profile_attributes: [:first_name, :last_name])
  end
end
