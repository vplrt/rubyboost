class Users::DashboardsController < ApplicationController
  authorize_resource class: false

  def show
    @dashboard = DashboardPresenter.new current_user, params
  end
end
