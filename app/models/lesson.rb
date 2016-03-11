class Lesson < ActiveRecord::Base
  validates :title, presence: true, length: { maximum: 100 }
  validates :description, presence: true
  validates :position, presence: true

  mount_uploader :picture, LessonPictureUploader

  scope :by_position, -> { order(position: :asc) }

  before_create :increment_positions
  after_destroy :decrement_positions

  belongs_to :user
  belongs_to :course
  has_many :homeworks, dependent: :destroy

  private

  def increment_positions
    Lesson.where(course_id: course_id).where('position >= ?', position).each do |les|
      les.increment! :position
    end
  end

  def decrement_positions
    Lesson.where(course_id: course_id).where('position >= ?', position).each do |les|
      les.decrement! :position
    end
  end
end
