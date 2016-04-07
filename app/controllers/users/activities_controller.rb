class Users::ActivitiesController < Users::BaseController
  PER_PAGE = 9

  def index
    @activities = current_user.feeds.includes(:trackable, owner: [:profile]).recent.page(params[:page]).per(PER_PAGE).decorate
  end
end
