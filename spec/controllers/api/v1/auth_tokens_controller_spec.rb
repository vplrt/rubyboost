require 'rails_helper'

RSpec.describe Api::V1::AuthTokensController do
  describe 'POST create' do
    context 'by email-password valid credentials' do
      let(:user) { create :user, password: '11111111' }

      subject { post :create, { email: user.email, password: '11111111' }, format: :json }

      it { expect(subject).to be_success }

      it 'response contains auth_token' do
        expect(subject.body).to have_json_type(String).at_path('auth_token')
      end
    end
  end
end
