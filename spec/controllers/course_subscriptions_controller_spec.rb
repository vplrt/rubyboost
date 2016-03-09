require 'rails_helper'

RSpec.describe CourseSubscriptionsController, type: :controller do
  let(:course) { create :course }

  describe '#create' do
    login_user

    it 'adds current user to course participants ' do
      expect { post :create, course_id: course.id, format: :js }.to change(course.participants, :count).by(1)
    end
  end

  describe '#destroy' do
    login_user

    it 'adds current user to course participants ' do
      post :create, course_id: course.id, format: :js
      expect { delete :destroy, course_id: course.id, format: :js }.to change(course.participants, :count).by(-1)
    end
  end
end
