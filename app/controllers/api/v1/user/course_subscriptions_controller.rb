class Api::V1::User::CourseSubscriptionsController < Api::V1::User::BaseController
  before_action :find_course

  def create
    authorize! :subscribe, CourseUser
    result = ManageUserSubscriptionsService.subscribe(@course, current_user)
    form_respond result
  end

  def destroy
    authorize! :unsubscribe, CourseUser
    result = ManageUserSubscriptionsService.unsubscribe(@course, current_user)
    form_respond result
  end

  private

  def form_respond(result)
    if result.success?
      respond_with_success result.message
    else
      render json: { success: false, message: result.message }, status: result.status
    end
  end

  def find_course
    @course ||= Course.find(params[:course_id])
  end
end
