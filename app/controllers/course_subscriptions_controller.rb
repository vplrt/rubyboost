class CourseSubscriptionsController < ApplicationController
  before_filter :authenticate_user!

  def create
    authorize! :subscribe, CourseUser

    if current_user.email.present?
      course.participants << current_user
    else
      flash[:alert] = 'Please fill in your email and password, before.'
      render js: "window.location = '#{edit_users_profile_path}'"
    end
  end

  def destroy
    authorize! :unsubscribe, CourseUser
    course.course_users.where(user_id: current_user).first.destroy
  end

  private

  def course
    @course ||= Course.find(params[:course_id])
  end
  helper_method :course
end
