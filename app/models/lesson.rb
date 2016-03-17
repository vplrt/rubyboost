class Lesson < ActiveRecord::Base
  belongs_to :user
  belongs_to :course
  has_many :homeworks, dependent: :destroy

  scope :by_position, -> { order(position: :asc) }

  validates :title, presence: true, length: { maximum: 100 }
  validates :description, presence: true
  validates :position, presence: true

  mount_uploader :picture, LessonPictureUploader

  before_create :increment_positions
  after_destroy :decrement_positions

  def user_homework(user)
    homeworks.where(user: user).first
  end

  private

  def increment_positions
    Lesson.where(course_id: course_id).where('position >= ?', position).each do |lesson|
      lesson.increment! :position
    end
  end

  def decrement_positions
    Lesson.where(course_id: course_id).where('position >= ?', position).each do |lesson|
      lesson.decrement! :position
    end
  end
end
