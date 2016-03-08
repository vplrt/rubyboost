class CoursesController < ApplicationController
  PER_PAGE = 9

  def index
    @courses = Course.visible.includes(user: [:profile]).recent.page(params[:page]).per(PER_PAGE)
  end
end
