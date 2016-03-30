# rubocop: disable Style/RedundantSelf
class User < ActiveRecord::Base
  rolify
  include Omniauthable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:vkontakte, :twitter]

  has_one  :profile, dependent: :destroy
  has_many :social_profiles, dependent: :destroy
  has_many :courses, dependent: :destroy
  has_many :course_users, dependent: :destroy
  has_many :participated_courses, through: :course_users, source: :course
  has_many :lessons, dependent: :destroy
  has_many :homeworks, dependent: :destroy
  has_many :feeds, class_name: 'Activity', foreign_key: :recipient_id, dependent: :destroy
  has_many :actions, class_name: 'Activity', foreign_key: :owner_id, dependent: :destroy

  before_save  :ensure_authentication_token
  after_create :create_user_profile

  accepts_nested_attributes_for :profile

  delegate :first_name, :last_name, to: :profile, allow_nil: true

  def full_name
    first_name + ' ' + last_name
  end

  def participate_in?(course)
    course_users.exists?(course_id: course.id)
  end

  def expelled?(course)
    course_users.find_by(course_id: course.id).try(:expelled)
  end

  private

  def create_user_profile
    return if profile
    build_profile
    profile.save(validates: false)
  end

  def ensure_authentication_token
    return unless self.authentication_token.blank?
    self.authentication_token = generate_authentication_token
  end

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.exists?(authentication_token: token)
    end
  end
end
