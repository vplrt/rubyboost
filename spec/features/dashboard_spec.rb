require 'rails_helper'

feature 'Dashboard' do
  given(:user) { create(:user) }
  given!(:course) { create(:course, user: user) }

  background do
    signin(user.email, user.password)
    visit dashboard_path
  end

  scenario 'user can navigate by CRUD actions here' do
    expect(page).to have_content course.title
    expect(page).to have_link 'Create new course'
    expect(page).to have_link 'Edit'
    expect(page).to have_link 'Delete'
  end

  scenario "has link 'Edit account'" do
    expect(page).to have_link 'Edit account'
  end
end
