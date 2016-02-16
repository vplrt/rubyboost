require 'rails_helper'

feature 'Attach picture to course' do
  background do
    visit new_course_path
  end

  scenario 'User is able to add picture when creates course' do
    fill_in 'Title', with: 'Test course.'
    attach_file 'Picture', "#{Rails.root}/spec/support/test.png"
    click_on 'Save'
    expect(page).to have_css("img[src*='thumb_test.png']")
  end
end
