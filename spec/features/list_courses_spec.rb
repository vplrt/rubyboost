require 'rails_helper'

feature 'Courses list' do
  given!(:course_1) { create(:course) }
  given!(:course_2) { create(:course, visible: false) }

  scenario 'User is able to see only visible courses.' do
    visit courses_path
    expect(page).to have_content course_1.title
    expect(page).to_not have_content course_2.title
  end
end
