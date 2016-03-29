require 'rails_helper'

feature 'Course CRUD' do
  given(:coach) { create(:coach) }
  given!(:course) { create(:course, user: coach) }

  background do
    signin(coach.email, coach.password)
  end

  scenario 'Coach is able to create course.' do
    visit new_users_course_path
    fill_in 'Title', with: 'Test course.'
    choose('No')
    expect do
      click_button 'Save'
    end.to change(Course, :count).by(1)

    expect(page).to have_content 'Создан новый курс.'
  end

  scenario 'Coach is able to delete course.' do
    visit dashboard_path
    expect do
      click_link 'Delete'
    end.to change(Course, :count).by(-1)

    expect(page).to have_content 'Курс удален!'
  end

  scenario 'Coach is able to update course.' do
    visit edit_users_course_path course
    fill_in 'Title', with: 'Other course.'
    click_button 'Save'

    expect(page).to have_content 'Other course.'
    expect(page).to have_content 'Курс успешно обновлен.'
  end
end
