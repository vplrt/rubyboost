class DashboardPresenter
  PER_PAGE = 5

  attr_reader :user, :params

  def initialize(user, params={})
    @user = user
    @params = params
  end

  def courses
    @user.courses.includes(:lessons).recent.page(params[:page]).per(PER_PAGE)
  end

  def participated_courses
    @user.participated_courses.recent.page(params[:page]).per(PER_PAGE)
  end
end
