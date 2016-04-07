class CourseSubscriptionsController < ApplicationController
  before_filter :authenticate_user!

  def create
    authorize! :subscribe, CourseUser
    result = ManageUserSubscriptionsService.subscribe(course, current_user)
    return if result.success?

    flash[:alert] = result.message
    render js: "window.location = '#{edit_users_profile_path}'"
  end

  def destroy
    authorize! :unsubscribe, CourseUser
    ManageUserSubscriptionsService.unsubscribe(course, current_user)
  end

  private

  def course
    @course ||= Course.find(params[:course_id])
  end
  helper_method :course
end
