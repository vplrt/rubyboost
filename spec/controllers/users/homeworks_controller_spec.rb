require 'rails_helper'

RSpec.describe Users::HomeworksController, type: :controller do
  let!(:lesson) { create :lesson }

  describe '#create' do
    login_user(:user)
    it 'saves the homework in the database' do
      expect { post :create, homework: attributes_for(:homework), lesson_id: lesson.id, format: :js }.to\
        change(Homework, :count).by(1)
    end
  end
end
