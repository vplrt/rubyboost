class User < ActiveRecord::Base
  rolify
  include Omniauthable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:vkontakte, :twitter]

  has_one  :profile, dependent: :destroy
  has_many :social_profiles
  has_many :courses, dependent: :destroy
  has_many :course_users
  has_many :participated_courses, through: :course_users, source: :course
  has_many :lessons, dependent: :destroy
  has_many :homeworks, dependent: :destroy

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
end
