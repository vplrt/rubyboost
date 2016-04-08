class Users::HomeworksController < Users::BaseController
  before_action :find_homework, only: [:show, :approve, :reject]
  authorize_resource

  def show
    @comment_for_reject = current_user.comments.build
  end

  def index
    @homeworks = lesson.homeworks.includes(:user)
  end

  def create
    @homework = lesson.homeworks.build(homework_params)
    @homework.user = current_user
    render :new unless @homework.save
  end

  def approve
    authorize! :approve, Homework
    @homework.approve!
    flash.now[:success] = 'Homework was approved!'
  end

  def reject
    authorize! :reject, Homework
    result = Homeworks::RejectService.perform(@homework, current_user, reject_params[:body])

    unless result.success?
      @comment_for_reject = result.comment_for_reject
      flash.now[:alert] = 'Please comment homework, when rejecting.'
    end
  end

  private

  def find_homework
    @homework = Homework.find(params[:id])
  end

  def homework_params
    params.require(:homework).permit(:body)
  end

  def reject_params
    params.require(:comment).permit(:body)
  end

  def lesson
    @lesson ||= Lesson.find(params[:lesson_id])
  end
  helper_method :lesson
end
