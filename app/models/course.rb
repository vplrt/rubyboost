class Course < ActiveRecord::Base
  belongs_to :user
  has_many :course_users
  has_many :participants, through: :course_users, source: :user
  has_many :lessons, dependent: :destroy

  scope :recent, -> { order(created_at: :desc) }
  scope :visible, -> { where(visible: true) }

  validates :title, presence: true, length: { maximum: 100 }

  mount_uploader :picture, CoursePictureUploader

  def course_user_id(user)
    course_users.where(user: user).first.id
  end
end
