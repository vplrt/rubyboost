class User < ActiveRecord::Base
  include Omniauthable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:vkontakte, :twitter]

  has_one  :profile
  has_many :social_profiles
  has_many :courses, dependent: :destroy

  after_create :create_user_profile

  accepts_nested_attributes_for :profile

  delegate :first_name, :last_name, to: :profile, allow_nil: true

  def full_name
    first_name + ' ' + last_name
  end

  private

  def create_user_profile
    build_profile
    profile.save(validates: false)
  end
end
