class Api::V1::User::ParticipatedCoursesController < Api::V1::User::BaseController
  def index
    courses = current_user.participated_courses
    respond_with_success courses
  end
end
