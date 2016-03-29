class Api::V1::User::AuthoredCoursesController < Api::V1::BaseController
  def index
    author = User.find(params[:id])
    courses = author.courses
    respond_with_success courses
  end
end
