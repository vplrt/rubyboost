require 'rails_helper'

feature 'Course subscription' do
  given(:course) { create(:course) }
  given(:user) { create(:user) }
  given(:course_user) { create(:expelled_course_user) }

  background do
    course.participants << user
  end

  scenario 'course author can expel subscribed user', js: true do
    signin(course.user.email, course.user.password)
    visit dashboard_path
    click_link 'Отчислить'
    wait_for_ajax
    expect(user.expelled?(course)).to eq(true)
  end

  scenario 'expelled user can visit course but cant visit lessons', js: true do
    signin(course_user.user.email, course_user.user.password)
    visit course_lessons_path course_user.course
    expect(page).to have_content 'Вы были отчислены с курса.'
  end
end
