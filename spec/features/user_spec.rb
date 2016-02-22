require 'rails_helper'

feature 'User', :devise do
  given(:user) { create(:user) }

  scenario 'can sign in with valid credentials' do
    signin(user.email, user.password)
    expect(page).to have_content I18n.t 'devise.sessions.signed_in'
  end

  scenario 'can sign out successfully' do
    signin(user.email, user.password)
    expect(page).to have_content I18n.t 'devise.sessions.signed_in'
    click_link 'Sign Out'
    expect(page).to have_content I18n.t 'devise.sessions.signed_out'
  end

  scenario 'can delete own account' do
    signin(user.email, user.password)
    visit edit_user_registration_path
    expect do
      click_link 'Cancel my account'
    end.to change(User, :count).by(-1)
    expect(page).to have_content I18n.t 'devise.registrations.destroyed'
  end

  scenario 'can edit account' do
    signin(user.email, user.password)
    visit edit_user_registration_path
    fill_in 'Email', with: 'newemail@example.com'
    fill_in 'Current password', with: user.password
    click_button 'Edit'
    txts = [I18n.t('devise.registrations.updated'), I18n.t('devise.registrations.update_needs_confirmation')]
    expect(page).to have_content(/.*#{txts[0]}.*|.*#{txts[1]}.*/)
  end
end
