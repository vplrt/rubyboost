FactoryGirl.define do
  factory :course do
    sequence(:title) { |n| "CourseTitle #{n}." }
    active true
  end
end
