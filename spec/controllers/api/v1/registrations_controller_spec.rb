require 'rails_helper'

RSpec.describe Api::V1::RegistrationsController do
  describe 'POST create' do
    context 'with valid credentials' do
      user = { user: { email: '1@1.ru', password: '11111111', password_confirmation: '11111111' } }
      subject { post :create, user, format: :json }

      it { expect(subject).to be_success }
      it { expect { subject }.to change { User.count }.by 1 }

      it 'response contains auth_token' do
        expect(subject.body).to have_json_type(String).at_path('auth_token')
      end
    end

    context 'with invalid credentials' do
      user = { user: { email: '', password: '', password_confirmation: '' } }
      subject { post :create, user, format: :json }

      it 'returns 422 status code' do
        expect(subject.status).to eq 422
      end
    end
  end
end
