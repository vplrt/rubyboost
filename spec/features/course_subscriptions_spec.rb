require 'rails_helper'

feature 'Course subscription' do
  given(:user) { create(:user) }
  given(:course_user) { create(:expelled_course_user) }
  given!(:course) { create(:course) }

  context 'unexpelled User' do
    background do
      signin(user.email, user.password)
    end

    scenario 'can subscribe to course', js: true do
      expect do
        click_link 'Подать заявку'
        wait_for_ajax
      end.to change(course.participants, :count).by(1)
    end

    scenario 'can unsubscribe from course', js: true do
      course.participants << user

      expect do
        click_link 'Отписаться'
        wait_for_ajax
      end.to change(course.participants, :count).by(-1)
    end
  end

  context 'expelled User' do
    background do
      signin(course_user.user.email, course_user.user.password)
    end

    scenario 'cant subscribe to course', js: true do
      expect do
        click_link 'Подать заявку'
        wait_for_ajax
      end.to change(course_user.course.participants, :count).by(0)
    end

    scenario 'cant unsubscribe from course' do
      expect do
        page.driver.submit :delete, course_subscriptions_path(course_user.course), {}
      end.to change(course_user.course.participants, :count).by(0)
    end
  end
end
