require 'rails_helper'

feature 'OmniAuth' do
  scenario 'user can sign in with Twitter account' do
    visit new_user_session_path
    mock_twitter_auth_hash
    click_link 'Sign in with Twitter'
    expect(page).to have_content I18n.t 'devise.sessions.signed_in'
  end

  scenario 'user can sign in with Vkontakte account' do
    visit new_user_session_path
    mock_vkontakte_auth_hash
    click_link 'Sign in with Vkontakte'
    expect(page).to have_content I18n.t 'devise.sessions.signed_in'
  end
end
