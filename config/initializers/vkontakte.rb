Vkontakte.setup do |config|
  config.app_id = ENV['vkontakte_token']
  config.app_secret = ENV['vkontakte_key']
  config.format = :json
  config.debug = false
  config.logger = File.open(Rails.root.join('log', 'vkontakte.log'), 'a')
end
