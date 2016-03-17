class CourseExpulsionsController < ApplicationController
  def create
    course_user.expel!
  end

  private

  def course_user
    CourseUser.find_by(course_id: params[:course_id], user_id: params[:user_id])
  end
  helper_method :course_user
end
