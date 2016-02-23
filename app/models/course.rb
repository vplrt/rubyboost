class Course < ActiveRecord::Base
  validates :title, presence: true, length: { maximum: 100 }

  mount_uploader :picture, CoursePictureUploader

  scope :recent, -> { order(created_at: :desc) }

  belongs_to :user
end
