class Users::HomeworksController < Users::BaseController
  before_action :find_homework, only: [:show, :approve, :reject]
  authorize_resource

  def show
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
    @homework.approve!
  end

  def reject
    @homework.reject!
  end

  private

  def find_homework
    @homework = Homework.find(params[:id])
  end

  def homework_params
    params.require(:homework).permit(:body)
  end

  def lesson
    @lesson ||= Lesson.find(params[:lesson_id])
  end
  helper_method :lesson
end
