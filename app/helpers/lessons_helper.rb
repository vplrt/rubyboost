module LessonsHelper
  def default_position
    course.lessons.count + 1
  end
end
