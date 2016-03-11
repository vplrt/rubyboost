class Users::HomeworksController < Users::BaseController
  def create
    @homework = lesson.homeworks.build(homework_params)
    @homework.user = current_user

    render :new unless @homework.save
  end

  private

  def homework_params
    params.require(:homework).permit(:body)
  end

  def lesson
    Lesson.find(params[:lesson_id])
  end

  helper_method :lesson
end
