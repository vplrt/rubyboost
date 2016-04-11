class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout :layout_by_resource

  rescue_from CanCan::AccessDenied, with: :formatted_not_autorized

  rescue_from ActiveRecord::RecordNotFound,
              ActionController::RoutingError,
              ActiveRecord::RecordInvalid,
              with: :redirect_with_error

  private

  def layout_by_resource
    devise_controller? ? 'devise_layout' : 'application'
  end

  def redirect_with_error
    flash[:error] = 'Something goes wrong'
    redirect_to root_path
  end

  def formatted_not_autorized
    respond_to do |format|
      format.html { not_autorized }
      format.js   { render nothing: true, status: :forbidden }
    end
  end

  def not_autorized
    flash[:error] = 'You not authorized to perform this action'
    redirect_to root_path
  end
end
