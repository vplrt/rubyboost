require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) { create :user }
  let(:lesson_comment) { create :lesson_comment, user: subject.current_user }
  let(:homework_comment) { create :homework_comment, user: subject.current_user }
  let(:lesson) { create :lesson }
  let(:homework) { create :homework, user: user }

  describe '#create' do
    login_user(:user)

    before { lesson.course.participants << user }

    it 'saves the lesson\'s comment in the database' do
      expect { post :create, comment: attributes_for(:lesson_comment), lesson_id: lesson.id, format: :js }.to\
        change(Comment, :count).by(1)
    end

    it 'saves the homework\'s comment in the database' do
      expect { post :create, comment: attributes_for(:homework_comment), homework_id: homework.id, format: :js }.to\
        change(Comment, :count).by(1)
    end
  end

  describe '#destroy' do
    login_user(:user)

    it 'deletes the lesson\'s comment from the database' do
      lesson_comment

      expect { delete :destroy, lesson_id: lesson_comment.commentable_id, id: lesson_comment.id, format: :js }.to\
        change(Comment, :count).by(-1)
    end

    it 'deletes the homework\'s comment from the database' do
      homework_comment

      expect { delete :destroy, homework_id: homework_comment.commentable_id, id: homework_comment.id, format: :js }.to\
        change(Comment, :count).by(-1)
    end
  end
end
