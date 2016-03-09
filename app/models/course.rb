class Course < ActiveRecord::Base
  validates :title, presence: true, length: { maximum: 100 }

  mount_uploader :picture, CoursePictureUploader

  scope :recent, -> { order(created_at: :desc) }
  scope :visible, -> { where(visible: true) }

  belongs_to :user
  has_many :course_users
  has_many :participants, through: :course_users, source: :user
end
