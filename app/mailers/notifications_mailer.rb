class NotificationsMailer < ApplicationMailer
  def homework_state(homework, recipient)
    @homework = homework
    @recipient = recipient

    mail(to: recipient.email, subject: "Homework #{@homework.state}")
  end

  def lesson_notification(lesson, recipient, template)
    @lesson = lesson
    @recipient = recipient
    template = template

    mail(to: @recipient.email, subject: 'Lesson notification', template_name: template)
  end
end
