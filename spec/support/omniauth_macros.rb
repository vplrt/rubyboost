module OmniauthMacros
  def mock_twitter_auth_hash
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new(
      'provider': 'twitter',
      'uid': '12345',
      'extra': { 'raw_info': { 'name': 'Twitter User' } }
    )
  end

  def mock_vkontakte_auth_hash
    OmniAuth.config.mock_auth[:vkontakte] = OmniAuth::AuthHash.new(
      'provider': 'vkontakte',
      'uid': 'id12345678',
      'extra': { 'raw_info': { 'first_name': 'Vkontakte', 'last_name': 'User' } }
    )
  end
end
