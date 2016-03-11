class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout :layout_by_resource

  protected

  def layout_by_resource
    devise_controller? ? 'devise_layout' : 'application'
  end

  def filter_expelled_users!
    return unless current_user.expelled?(course)
    flash[:error] = 'Вы были отчислены с курса.'
    redirect_to course
  end
end
