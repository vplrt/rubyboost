FactoryGirl.define do
  factory :lesson do
    user
    course
    sequence(:title) { |n| "CourseTitle #{n}." }
    sequence(:position) { |n| n }
    sequence(:description) { |n| "Description #{n}." }
    sequence(:notes) { |n| "Notes #{n}." }
    sequence(:homework) { |n| "Homework #{n}." }
  end

  factory :invalid_lesson, class: 'Lesson' do
    user
    course
    title nil
    position nil
    description nil
    notes nil
    homework nil
  end
end
