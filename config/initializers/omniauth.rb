Rails.application.config.middleware.use OmniAuth::Builder do
  provider :vkontakte, OmniauthConfig['vkontakte']['token'], OmniauthConfig['vkontakte']['key']
  provider :twitter, OmniauthConfig['twitter']['token'], OmniauthConfig['twitter']['key']
end
