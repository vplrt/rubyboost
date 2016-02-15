class CoursesController < ApplicationController
  PER_PAGE = 10

  def index
    @courses = Course.recent.page(params[:page]).per(PER_PAGE)
  end
end
