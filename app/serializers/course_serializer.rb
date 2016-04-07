class CourseSerializer < ActiveModel::Serializer
  attributes :id, :title, :url

  def url
    course_url(object)
  end
end
