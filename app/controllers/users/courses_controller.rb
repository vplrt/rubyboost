class Users::CoursesController < Users::BaseController
  before_action :find_course, only: [:edit, :update, :destroy]

  def new
    @course = current_user.courses.build
  end

  def create
    @course = current_user.courses.build(course_params)

    if @course.save
      redirect_to dashboard_path, notice: 'Создан новый курс.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @course.update(course_params)
      redirect_to dashboard_path, notice: 'Курс успешно обновлен.'
    else
      render :edit
    end
  end

  def destroy
    @course.destroy

    redirect_to dashboard_path, notice: 'Курс удален!'
  end

  private

  def course_params
    params.require(:course).permit(:title, :visible, :picture)
  end

  def find_course
    @course = Course.find(params[:id])
  end
end
