FactoryGirl.define do
  factory :course do
    user

    sequence(:title) { |n| "CourseTitle #{n}." }
    active true
  end
end
