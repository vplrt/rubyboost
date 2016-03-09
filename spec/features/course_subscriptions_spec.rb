require 'rails_helper'

feature 'Course subscription' do
  given(:user) { create(:user) }
  given!(:course) { create(:course) }

  background do
    signin(user.email, user.password)
  end

  scenario 'User can subscribe to course', js: true do
    expect do
      click_link 'Подать заявку'
      wait_for_ajax
    end.to change(course.participants, :count).by(1)
  end

  scenario 'User can subscribe to course', js: true do
    course.participants << user

    expect do
      click_link 'Отписаться'
      wait_for_ajax
    end.to change(course.participants, :count).by(-1)
  end
end
