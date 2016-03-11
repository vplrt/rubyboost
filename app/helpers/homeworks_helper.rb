module HomeworksHelper
  def user_homework(user, lesson)
    Homework.find_by(user: user, lesson: lesson)
  end
end
