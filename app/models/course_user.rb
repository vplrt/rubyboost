class CourseUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :course
  validates :course_id, uniqueness: { scope: :user_id }
end
