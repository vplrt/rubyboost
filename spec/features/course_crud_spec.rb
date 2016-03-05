require 'rails_helper'

feature 'Course CRUD' do
  given(:user) { create(:user) }
  given!(:course) { create(:course, user: user) }

  background do
    signin(user.email, user.password)
  end

  scenario 'User is able to create course.' do
    visit new_users_course_path
    fill_in 'Title', with: 'Test course.'
    expect do
      click_button 'Save'
    end.to change(Course, :count).by(1)

    expect(page).to have_content 'Создан новый курс.'
  end

  scenario 'User is able to delete course.' do
    visit dashboard_path user
    expect do
      click_link 'Delete'
    end.to change(Course, :count).by(-1)

    expect(page).to have_content 'Курс удален!'
  end

  scenario 'User is able to delete course.' do
    visit edit_users_course_path course
    fill_in 'Title', with: 'Other course.'
    click_button 'Save'

    expect(page).to have_content 'Other course.'
    expect(page).to have_content 'Курс успешно обновлен.'
  end
end
