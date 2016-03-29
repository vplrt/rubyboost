require 'rails_helper'

RSpec.describe Api::V1::User::AuthoredCoursesController do
  let!(:course) { create(:course) }
  let!(:user) { create(:user) }
  let!(:users_course) { create(:course, user: user) }

  describe 'GET index' do
    before { get :index, id: user.id, format: :json }

    it { expect(response).to be_success }

    it "response contains users's course" do
      expect(response.body).to have_content(users_course.title)
    end

    it "response doesn\'t contains foreign authored course" do
      expect(response.body).to_not have_content(course.title)
    end
  end
end
