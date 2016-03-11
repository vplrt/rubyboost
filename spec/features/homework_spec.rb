require 'rails_helper'

feature 'Homework' do
  given(:lesson) { create(:lesson) }
  given(:user) { create(:user) }

  scenario 'user can send his homework.', js: true do
    signin(user.email, user.password)
    visit course_lesson_path(lesson.course, lesson)
    expect do
      click_button 'Send hometask'
      wait_for_ajax
      fill_in 'Body', with: 'Test body.'
      click_button 'Send'
      wait_for_ajax
    end.to change(Homework, :count).by(1)
  end
end
