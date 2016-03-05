FactoryGirl.define do
  factory :course do
    user

    sequence(:title) { |n| "CourseTitle #{n}." }
    visible true
  end
end
