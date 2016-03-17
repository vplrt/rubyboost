class CourseSubscriptionsController < ApplicationController
  before_filter :authenticate_user!

  def create
    course.participants << current_user
  end

  def destroy
    if current_user.expelled?(course)
      flash[:error] = 'Вы были отчислены с курса.'
      redirect_to root_path
    else
      course.course_users.where(user_id: current_user).first.destroy
    end
  end

  private

  def course
    @course ||= Course.find(params[:course_id])
  end
  helper_method :course
end
