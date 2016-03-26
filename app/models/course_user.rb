class CourseUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

  validates :course_id, uniqueness: { scope: :user_id }

  after_commit :send_lesson_tomorrow_notifications, on: :create
  after_commit :create_user_subscribed_activity, on: :create
  after_commit :create_user_unsubscribed_activity, on: :destroy

  def expel!
    update!(expelled: true)
    create_user_expelled_activity
  end

  private

  def send_lesson_tomorrow_notifications
    course.lessons.each do |lesson|
      if DateTime.now < lesson.date.ago(1.day)
        LessonTomorrowNotificationWorker.perform_at(lesson.date.ago(1.day), lesson.id, user_id)
      end
    end
  end

  def create_user_subscribed_activity
    Activity.create!(
      owner_id: user_id,
      recipient_id: user_id,
      trackable: self,
      kind: Activity::KIND_USER_SUBSCRIBED,
      message: "You subscribed to course: #{course.title}"
    )
  end

  def create_user_unsubscribed_activity
    Activity.create!(
      owner_id: user_id,
      recipient_id: user_id,
      trackable: self,
      kind: Activity::KIND_USER_UNSUBSCRIBED,
      message: "You unsubscribed from course: #{course.title}"
    )
  end

  def create_user_expelled_activity
    Activity.create!(
      owner_id: course.user_id,
      recipient_id: user_id,
      trackable: self,
      kind: Activity::KIND_USER_EXPELLED,
      message: "You have been expelled from course: #{course.title}"
    )
  end
end
