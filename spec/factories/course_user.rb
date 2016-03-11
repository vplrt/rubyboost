FactoryGirl.define do
  factory :course_user do
    user
    course
  end

  factory :expelled_course_user, class: 'CourseUser' do
    user
    course
    expelled true
  end
end
