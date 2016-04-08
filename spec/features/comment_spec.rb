require 'rails_helper'

feature 'Comment' do
  given(:user) { create(:user) }
  given(:lesson) { create(:lesson) }
  given(:homework) { create(:homework, user: user) }

  background do
    signin(user.email, user.password)
    lesson.course.participants << user
  end

  context 'lesson' do
    given(:lesson_comment) { create :lesson_comment, commentable: lesson, user: user }

    scenario 'user is able to create comment', js: true do
      visit course_lesson_path(lesson.course, lesson)
      fill_in 'comment_body', with: 'Test'
      expect do
        click_button 'Add comment'
        wait_for_ajax
      end.to change(Comment, :count).by(1)

      expect(page).to have_content Comment.last.body
    end

    scenario 'user is able to delete comment', js: true do
      lesson_comment
      visit course_lesson_path(lesson.course, lesson)

      expect do
        click_link 'Delete'
        wait_for_ajax
      end.to change(Comment, :count).by(-1)
    end
  end

  context 'homework' do
    given(:homework_comment) { create :homework_comment, commentable: homework, user: user }

    scenario 'user is able to create comment', js: true do
      visit homework_path(homework.lesson, homework)
      fill_in 'comment_body', with: 'Test'
      expect do
        click_button 'Add comment'
        wait_for_ajax
      end.to change(Comment, :count).by(1)

      expect(page).to have_content Comment.last.body
    end

    scenario 'user is able to delete comment', js: true do
      homework_comment
      visit homework_path(homework.lesson, homework)

      expect do
        click_link 'Delete'
        wait_for_ajax
      end.to change(Comment, :count).by(-1)
    end
  end
end
