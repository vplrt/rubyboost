require 'rails_helper'

RSpec.describe Api::V1::User::ParticipatedCoursesController do
  let(:user) { create(:user) }
  let!(:courses) { create_list(:course, 2) }
  let(:course) { courses.first }

  describe 'GET index' do
    before { courses.each { |course| course.participants << user } }

    context 'with valid token' do
      before do
        get :index, format: :json, auth_token: user.authentication_token
      end

      it { expect(response).to be_success }

      it 'returns list of courses' do
        expect(response.body).to have_json_size(2).at_path('/')
      end

      %w(id title).each do |attr|
        it "course object contains #{attr}" do
          expect(response.body).to be_json_eql(course.send(attr.to_sym).to_json).at_path("0/#{attr}")
        end
      end

      it 'course object contains url' do
        expect(response.body).to have_json_type(String).at_path('0/url')
      end
    end

    context 'with invalid token' do
      before do
        get :index, format: :json, auth_token: 'invalid_token'
      end

      it 'returns 401 status code' do
        expect(response.status).to eq 401
      end
    end
  end
end
