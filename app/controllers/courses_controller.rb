class CoursesController < ApplicationController
  PER_PAGE = 9

  def index
    @courses = Course.visible.includes(:user).recent.page(params[:page]).per(PER_PAGE)
  end
end
