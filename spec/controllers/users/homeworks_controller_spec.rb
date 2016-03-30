require 'rails_helper'

RSpec.describe Users::HomeworksController, type: :controller do
  let(:coach) { create :coach }
  let(:lesson) { create :lesson, user: coach }
  let!(:homework) { create :homework, lesson: lesson }

  describe '#show' do
    login_user(:coach)
    before { get :show, lesson_id: lesson.id, id: homework.id }

    it 'assings the requested homework to @homework' do
      expect(assigns(:homework)).to eq homework
    end
  end

  describe '#index' do
    let!(:homework_2) { create :homework, lesson: lesson }
    login_user(:coach)

    before { get :index, lesson_id: lesson.id }

    specify do
      expect(assigns(:homeworks)).to match_array [homework_2, homework]
    end
  end

  describe '#create' do
    login_user(:user)
    it 'saves the homework in the database' do
      expect { post :create, homework: attributes_for(:homework), lesson_id: lesson.id, format: :js }.to\
        change(Homework, :count).by(1)
    end
  end
end
