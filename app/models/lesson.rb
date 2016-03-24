class Lesson < ActiveRecord::Base
  include AASM

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

  aasm column: :state do
    state :pending_conduction, initial: true
    state :pending_for_materials
    state :materials_uploaded

    event :conduct_lesson do
      transitions from: :pending_conduction, to: :pending_for_materials
    end

    event :send_materials do
      transitions from: :pending_for_materials, to: :materials_uploaded, after: :send_lesson_notification
    end
  end

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

  def send_lesson_notification
    ScheduleMaterialsUploadedNotificationWorker.perform_async(id)
  end
end
