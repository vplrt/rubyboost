module DashboardsHelper
  def course_user_id(course, user)
    CourseUser.find_by(course: course, user: user).id
  end
end
