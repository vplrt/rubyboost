module Omniauthable
  extend ActiveSupport::Concern

  included do
    attr_accessor :social_login

    def self.find_or_create_with_oauth(oauth_data)
      find_with_oauth(oauth_data) || create_with_oauth(oauth_data)
    end

    def self.find_with_oauth(oauth_data)
      find_through_authorization(oauth_data.provider, oauth_data.uid)
    end

    def self.find_through_authorization(service_name, uid)
      social_profile = SocialProfile.where(service_name: service_name, uid: uid).first
      social_profile.present? ? social_profile.user : nil
    end

    def self.create_with_oauth(oauth_data)
      if oauth_data.size > 2
        first_name, last_name = parse_name(oauth_data)
        user = User.new(profile_attributes: { first_name: first_name, last_name: last_name })
      else
        user = User.new
      end
      user.social_login = true

      user.save!
      user
    end

    def self.parse_name(oauth_data)
      if oauth_data.provider == 'vkontakte'
        [oauth_data.extra.raw_info.first_name, oauth_data.extra.raw_info.last_name]
      else
        oauth_data.extra.raw_info.name.split(' ')
      end
    end

    def register_social_profile(service_name, uid)
      social_profile = SocialProfile.where(service_name: service_name, uid: uid).first_or_create

      return false if social_profile.user_id.present? && social_profile.user_id != id

      social_profile.update!(user_id: id)

      social_profile.persisted? ? social_profile : false
    end

    def password_required?
      return false if social_login
      !persisted? || !password.nil? || !password_confirmation.nil?
    end

    def email_required?
      !social_login
    end
  end
end
