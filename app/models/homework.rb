class Homework < ActiveRecord::Base
  include AASM

  belongs_to :user
  belongs_to :lesson

  has_many :activities, as: :trackable, dependent: :destroy

  validates :body, presence: true
  validates :user_id, uniqueness: { scope: :lesson_id, allow_blank: false }

  aasm column: :state do
    state :pending, initial: true
    state :approved
    state :rejected

    event :approve, after_commit: [:send_homework_state_notification, :create_homework_activity] do
      transitions from: :pending, to: :approved
    end

    event :reject, after_commit: [:send_homework_state_notification, :create_homework_activity] do
      transitions from: :pending, to: :rejected
    end
  end

  private

  def send_homework_state_notification
    HomeworkStateNotificationWorker.perform_async(id, user.id)
  end

  def create_homework_activity
    Activity.create!(
      owner_id: lesson.user_id,
      recipient_id: user.id,
      trackable: self,
      kind: approved? ? Activity::KIND_HOMEWORK_APPROVED : Activity::KIND_HOMEWORK_REJECTED,
      message: "Your homework for course  '#{lesson.course.title}' Lesson '#{lesson.position}: #{lesson.title}' was #{state}!"
    )
  end
end
