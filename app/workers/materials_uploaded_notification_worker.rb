class MaterialsUploadedNotificationWorker
  include Sidekiq::Worker

  sidekiq_options queue: 'notifications', retry: true, failure: true

  def perform(lesson_id, user_id)
    lesson = Lesson.find(lesson_id)
    user = User.find(user_id)

    NotificationsMailer.lesson_notification(lesson, user, 'materials_uploaded').deliver
  end
end
