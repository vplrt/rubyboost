class LessonsController < Users::BaseController
  before_filter :authenticate_user!
  before_filter :filter_expelled_users!, only: [:index, :show]
  before_action :find_lesson, only: [:show, :destroy]
  authorize_resource except: [:index]

  def show
    @homework = @lesson.homeworks.build
  end

  def index
    @lessons = course.lessons.by_position
  end

  def new
    @lesson = course.lessons.build
  end

  def create
    @lesson = course.lessons.build(lesson_params)
    @lesson.user_id = current_user.id

    if @lesson.save
      redirect_to dashboard_path, notice: 'Создан новый Урок.'
    else
      render :new
    end
  end

  def destroy
    @lesson.destroy

    redirect_to dashboard_path, notice: 'Урок удален!'
  end

  private

  def lesson_params
    params.require(:lesson).permit(:title, :position, :description, :notes, :homework, :picture)
  end

  def find_lesson
    @lesson ||= Lesson.find(params[:id])
  end

  def course
    @course ||= Course.find(params[:course_id])
  end

  helper_method :course

  def filter_expelled_users!
    return unless current_user.expelled?(course)
    flash[:error] = 'Вы были отчислены с курса.'
    redirect_to course
  end
end
