class MaterialsUploadedActivityWorker
  include Sidekiq::Worker

  sidekiq_options queue: 'feeds', failure: true

  def perform(lesson_id)
    lesson = Lesson.find(lesson_id)

    lesson.course.participants.pluck(:user_id).each do |recipient_id|
      Activity.create!(
        owner_id: lesson.user_id,
        recipient_id: recipient_id,
        trackable: lesson,
        kind: Activity::KIND_LESSON_MATERIALS_UPLOADED,
        message: "Materials for Lesson '#{lesson.title}' of '#{lesson.course.title}' course was uploaded!"
      )
    end
  end
end
