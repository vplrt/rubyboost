require 'rails_helper'

feature 'Create' do
  given(:coach) { create(:coach) }
  given!(:course) { create(:course, user: coach) }

  background do
    signin(coach.email, coach.password)
  end

  scenario 'Course author is able to create lesson.' do
    visit new_course_lesson_path course
    fill_in 'Title', with: 'Test course.'
    # select 'June', from: 'lesson[date(2i)]'
    fill_in 'Description', with: 'Test description'
    fill_in 'Notes', with: 'Test notes.'
    fill_in 'Homework', with: 'Test homework'
    attach_file 'Picture', "#{Rails.root}/spec/support/test.png"

    expect do
      click_button 'Save'
    end.to change(Lesson, :count).by(1)

    expect(page).to have_content 'Создан новый Урок.'
  end
end
