require 'rails_helper'

feature 'Homework' do
  given(:user) { create(:user) }
  given(:coach) { create(:coach) }
  given(:lesson) { create(:lesson, user: coach) }
  given(:homework) { create(:homework, lesson: lesson) }

  before { lesson.course.participants << user }

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

  scenario 'coach can approve user\'s homework.', js: true do
    signin(coach.email, coach.password)
    visit homework_path(lesson, homework)
    click_link 'Approve'
    wait_for_ajax
    expect(page).to have_content('Approved')
  end

  scenario 'coach can reject user\'s homework.', js: true do
    signin(coach.email, coach.password)
    visit homework_path(lesson, homework)
    click_link 'Reject'
    wait_for_ajax
    expect(page).to have_content('Rejected')
  end
end
