require 'rails_helper'

feature 'OmniAuth' do
  before { visit new_user_session_path }

  scenario 'user can sign in with Twitter account' do
    mock_twitter_auth_hash
    click_link 'Sign in with Twitter'
    expect(page).to have_content I18n.t 'devise.sessions.signed_in'
  end

  scenario 'user can sign in with Vkontakte account' do
    mock_vkontakte_auth_hash
    click_link 'Sign in with Vkontakte'
    expect(page).to have_content I18n.t 'devise.sessions.signed_in'
  end

  scenario 'user will get profile fith first name and last name' do
    mock_vkontakte_auth_hash
    click_link 'Sign in with Vkontakte'
    visit edit_users_profile_path
    expect(page).to have_content User.last.last_name
  end
end
