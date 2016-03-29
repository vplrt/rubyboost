class Api::V1::AuthTokensController < Api::V1::BaseController
  def create
    if params[:email].present? && params[:password].present?
      auth_token = authenticate_by_email
    elsif params[:service_name].present?
      auth_token = authenticate_through_social_network
    end

    raise NotAuthorized unless auth_token.present?

    render json: { success: true, auth_token: auth_token }, status: 201
  end

  private

  def authenticate_by_email
    user = User.find_by_email(params[:email])
    user.authentication_token if user.present? && user.valid_password?(params[:password])
  end

  def authenticate_through_social_network
    return nil unless params[:service_name] == 'twitter' || params[:service_name] == 'vkontakte'
    user = find_or_create_oauth_user
    user.authentication_token if user.present?
  end

  def twitter_uid
    twitter_client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['twitter_token']
      config.consumer_secret     = ENV['twitter_key']
      config.access_token        = params[:access_token]
      config.access_token_secret = params[:secret_key]
    end

    twitter_client.user['id']
  end

  def vkontakte_uid
    vkontakte_client = Vkontakte::App::User.new(params[:uid], access_token: params[:access_token])
    vkontakte_client.fetch[0]['id']
  end

  def find_or_create_oauth_user
    oauth_data = OmniAuth::AuthHash.new(provider: params[:service_name], uid: send("#{params[:service_name]}_uid"))
    user = User.find_or_create_with_oauth(oauth_data)
    user.register_social_profile(oauth_data.provider, oauth_data.uid)
    user
  end
end
