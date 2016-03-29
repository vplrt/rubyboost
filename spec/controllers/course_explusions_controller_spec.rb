require 'rails_helper'

RSpec.describe CourseExpulsionsController, type: :controller do
  let(:coach) { create :coach }
  let(:user) { create :user }
  let(:course) { create :course, user: coach }

  context 'by coach' do
    before { course.participants << user }
    login_user(:coach)

    describe '#create' do
      it 'change course_users.expelled to true' do
        post :create, course_id: course.id, user_id: user.id, format: :js
        expect(course.course_users.first.expelled).to eq true
      end
    end
  end

  context 'by user' do
    before { course.participants << user }
    login_user(:user)

    describe '#create' do
      it 'doesnt change course_users.expelled to true' do
        post :create, course_id: course.id, user_id: user.id, format: :js
        expect(course.course_users.first.expelled).to eq false
      end
    end
  end
end
