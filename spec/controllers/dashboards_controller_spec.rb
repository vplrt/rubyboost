require 'rails_helper'

RSpec.describe Users::DashboardsController, type: :controller do
  describe '#show' do
    login_user
    before { get :show }

    specify do
      expect(assigns(:dashboard)).to be_a DashboardPresenter
    end
  end
end
