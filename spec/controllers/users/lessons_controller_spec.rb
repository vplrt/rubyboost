require 'rails_helper'

RSpec.describe Users::LessonsController, type: :controller do
  let(:course) { create :course }
  let!(:lesson) { create :lesson, course: course }
  let(:invalid_lesson) { create :invalid_lesson }

  describe '#create' do
    login_user

    before { get :new, course_id: course }

    it 'assigns a new Lesson to @lesson' do
      expect(assigns(:lesson)).to be_a_new(Lesson)
    end
  end

  describe '#create' do
    login_user

    it 'saves the new lesson in the database' do
      expect { post :create, lesson: attributes_for(:lesson), course_id: course }.to change(Lesson, :count).by(1)
    end

    it 'does not save the lesson with invalid attributes' do
      expect { post :create, lesson: attributes_for(:invalid_lesson), course_id: course }.to change(Lesson, :count).by(0)
    end
  end

  describe '#destroy' do
    login_user

    it 'deletes lesson from the database' do
      expect { delete :destroy, id: lesson, course_id: course }.to change(Lesson, :count).by(-1)
    end
  end
end
