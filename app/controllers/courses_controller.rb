class CoursesController < ApplicationController
  before_action :find_course, only: [:edit, :update, :destroy]

  PER_PAGE = 10

  def index
    @courses = Course.recent.page(params[:page]).per(PER_PAGE)
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)

    if @course.save
      redirect_to courses_path, notice: 'Создан новый курс.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @course.update(course_params)
      redirect_to courses_path, notice: 'Курс успешно обновлен.'
    else
      render :edit
    end
  end

  def destroy
    @course.destroy
    redirect_to courses_path, notice: 'Курс удален!'
  end

  private

  def course_params
    params.require(:course).permit(:title, :active)
  end

  def find_course
    @course = Course.find(params[:id])
  end
end
