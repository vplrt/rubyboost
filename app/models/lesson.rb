class Lesson < ActiveRecord::Base
  validates :title, presence: true, length: { maximum: 100 }
  validates :description, presence: true
  validates :position, presence: true

  mount_uploader :picture, LessonPictureUploader

  belongs_to :user
  belongs_to :course
end
