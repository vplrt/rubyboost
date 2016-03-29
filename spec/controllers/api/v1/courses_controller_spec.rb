require 'rails_helper'

RSpec.describe Api::V1::CoursesController do
  let!(:courses) { create_list(:course, 2) }
  let(:course) { courses.first }

  describe 'GET index' do
    before { get :index, format: :json }

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
end
