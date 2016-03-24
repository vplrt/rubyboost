class ScheduleMaterialsUploadedNotificationWorker
  include Sidekiq::Worker

  sidekiq_options queue: 'notifications', failure: true

  def perform(lesson_id)
    lesson = Lesson.find(lesson_id)

    lesson.course.participants.pluck(:user_id).each do |user_id|
      MaterialsUploadedNotificationWorker.perform_async(lesson_id, user_id)
    end
  end
end
