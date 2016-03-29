require 'rails_helper'

feature 'Dashboard' do
  given(:coach) { create(:coach) }
  given(:user) { create(:user) }
  given!(:course) { create(:course, user: coach) }

  context 'Coach user' do
    background do
      signin(coach.email, coach.password)
      visit dashboard_path
    end

    scenario 'can navigate by course CRUD actions here' do
      expect(page).to have_content course.title
      expect(page).to have_link 'Create new course'
      within('ul.products-list.product-list-in-box') do
        expect(page).to have_link 'Edit'
        expect(page).to have_link 'Delete'
      end
    end
  end

  context 'Student user' do
    background do
      signin(user.email, user.password)
      course.participants << user
      visit dashboard_path
    end

    scenario 'cant navigate by course CRUD actions here' do
      expect(page).to_not have_link 'Create new course'
      within('ul.products-list.product-list-in-box') do
        expect(page).to_not have_link 'Edit'
        expect(page).to_not have_link 'Delete'
      end
    end

    scenario 'able to see the participated course list' do
      expect(page).to have_content course.title
    end
  end
end
