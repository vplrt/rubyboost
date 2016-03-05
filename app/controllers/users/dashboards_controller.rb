class Users::DashboardsController < ApplicationController
  def show
    @dashboard = DashboardPresenter.new current_user, params
  end
end
