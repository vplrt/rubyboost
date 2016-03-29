require 'rails_helper'

RSpec.describe CourseSubscriptionsController, type: :controller do
  let(:course) { create :course }

  login_user(:user)

  describe '#create' do
    it 'adds current user to course participants' do
      expect { post :create, course_id: course.id, format: :js }.to change(course.participants, :count).by(1)
    end
  end

  describe '#destroy' do
    it 'deletes current user from course participants ' do
      post :create, course_id: course.id, format: :js
      expect { delete :destroy, course_id: course.id, format: :js }.to change(course.participants, :count).by(-1)
    end
  end
end
