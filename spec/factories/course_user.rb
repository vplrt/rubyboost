FactoryGirl.define do
  factory :course_user do
    user
    course

    factory :expelled_course_user do
      expelled true
    end
  end
end
