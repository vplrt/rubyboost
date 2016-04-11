module CommentsHelper
  def parent_comment_path(parent, comment)
    return lesson_comment_path(parent, comment) if parent.is_a? Lesson
    return homework_comment_path(parent, comment) if parent.is_a? Homework
  end
end
