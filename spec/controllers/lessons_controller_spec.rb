require 'rails_helper'

RSpec.describe Users::LessonsController, type: :controller do
  let(:coach) { create :coach }
  let(:user) { create :user }
  let(:course) { create :course, user: coach }
  let(:lesson) { create :lesson, course: course, user: coach }

  describe '#show' do
    login_user(:user)

    context 'unsubscribed user' do
      before { get :show, id: lesson.id, course_id: course.id }

      it 'redirected to the root_path' do
        expect(response).to redirect_to root_path
      end
    end

    context 'subscribed user' do
      before do
        course.participants << user
        get :show, id: lesson.id, course_id: course.id
      end

      it 'redirected to the root_path' do
        expect(assigns(:lesson)).to eq lesson
      end
    end
  end

  describe '#new' do
    login_user(:coach)

    before { get :new, course_id: course }

    it 'assigns a new Lesson to @lesson' do
      expect(assigns(:lesson)).to be_a_new(Lesson)
    end
  end

  describe '#create' do
    login_user(:coach)

    it 'saves the new lesson in the database' do
      expect { post :create, lesson: attributes_for(:lesson), course_id: course }.to change(Lesson, :count).by(1)
    end

    it 'does not save the lesson with invalid attributes' do
      expect { post :create, lesson: attributes_for(:lesson, title: nil), course_id: course }.to change(Lesson, :count).by(0)
    end
  end

  describe '#destroy' do
    before { lesson }

    it 'deletes lesson from the database' do
      sign_in coach
      expect { delete :destroy, id: lesson.id, course_id: course.id }.to change(Lesson, :count).by(-1)
    end
  end
end
