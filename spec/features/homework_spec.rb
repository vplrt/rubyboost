require 'rails_helper'

feature 'Homework' do
  given(:user) { create(:user) }
  given(:coach) { create(:coach) }
  given(:lesson) { create(:lesson, user: coach) }
  given(:homework) { create(:homework, lesson: lesson) }
  given(:homework_comment) { create :homework_comment, commentable: homework, user: coach }

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

  scenario 'coach can\'t reject user\'s homework if uncommented.', js: true do
    signin(coach.email, coach.password)
    visit homework_path(lesson, homework)
    within('div.box-footer') do
      click_button 'Reject'
    end

    within('div#reject_comment') do
      click_button 'Reject'
    end

    wait_for_ajax
    expect(page).to have_content('Please comment homework, when rejecting.')
    expect(Homework.last.pending?).to eq true
  end

  scenario 'coach can reject user\'s homework if commented.', js: true do
    signin(coach.email, coach.password)
    visit homework_path(lesson, homework)
    within('div.box-footer') do
      click_button 'Reject'
    end

    within('div#reject_comment') do
      fill_in 'comment_body', with: 'Test body.'
      click_button 'Reject'
    end

    wait_for_ajax
    expect(page).to have_content('Rejected')
    expect(Homework.last.rejected?).to eq true
  end
end
