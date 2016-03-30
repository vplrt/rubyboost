class Api::V1::User::CourseSubscriptionsController < Api::V1::User::BaseController
  def create
    authorize! :subscribe, course_user if course_user
    if current_user.email.present?
      course.participants << current_user
      respond_with_success course
    else
      render json: { success: false, errors_messages: 'Please fill in your email and password, before.' }, status: 422
    end
  end

  def destroy
    if current_user.participate_in?(course)
      authorize! :unsubscribe, course_user
      course_user.destroy
      respond_with_success course
    else
      render json: { success: false, errors_messages: "Can't unsubscribe from this course." }, status: 400
    end
  end

  private

  def course
    @course ||= Course.find(params[:course_id])
  end

  def course_user
    @course_user ||= course.course_users.where(user_id: current_user).first
  end
end
