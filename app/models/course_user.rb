class CourseUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

  validates :course_id, uniqueness: { scope: :user_id }

  after_commit :send_lesson_tomorrow_notifications, on: :create

  def expel!
    update!(expelled: true)
  end

  private

  def send_lesson_tomorrow_notifications
    course.lessons.each do |lesson|
      if DateTime.now < lesson.date.ago(1.day)
        LessonTomorrowNotificationWorker.perform_at(lesson.date.ago(1.day), lesson.id, user_id)
      end
    end
  end
end
