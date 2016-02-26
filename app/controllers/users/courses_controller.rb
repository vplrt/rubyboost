class Users::CoursesController < ApplicationController
  before_filter :authenticate_user!
  before_action :find_course, only: [:edit, :update, :destroy]

  PER_PAGE = 9

  def index
    @courses = current_user.courses.recent.page(params[:page]).per(PER_PAGE)
  end

  def new
    @course = current_user.courses.build
  end

  def create
    @course = current_user.courses.build(course_params)

    if @course.save
      redirect_to user_path(current_user), notice: 'Создан новый курс.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @course.update(course_params)
      redirect_to user_path(current_user), notice: 'Курс успешно обновлен.'
    else
      render :edit
    end
  end

  def destroy
    @course.destroy

    redirect_to user_path(current_user), notice: 'Курс удален!'
  end

  private

  def course_params
    params.require(:course).permit(:title, :active, :picture)
  end

  def find_course
    @course = Course.find(params[:id])
  end
end
