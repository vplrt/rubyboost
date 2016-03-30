class Api::V1::User::AuthoredCoursesController < Api::V1::BaseController
  def index
    respond_with_success User.find(params[:id]).courses
  end
end
