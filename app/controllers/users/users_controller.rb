class Users::UsersController < ApplicationController
  before_filter :authenticate_user!

  PER_PAGE = 5

  def show
    @user = User.find(params[:id])
    @courses = @user.courses.recent.page(params[:page]).per(PER_PAGE)
  end
end
