class HomeworkStateNotificationWorker
  include Sidekiq::Worker

  sidekiq_options queue: 'notifications', retry: true, failure: true

  def perform(homework_id, user_id)
    homework = Homework.find(homework_id)
    user = User.find(user_id)

    NotificationsMailer.homework_state(homework, user).deliver
  end
end
