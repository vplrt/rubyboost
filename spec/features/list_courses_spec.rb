require 'rails_helper'

feature 'Courses list' do
  given!(:course) { create(:course) }

  scenario 'User is able to see a courses list.' do
    visit courses_path
    expect(page).to have_content course.title
  end
end
