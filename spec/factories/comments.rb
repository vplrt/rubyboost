FactoryGirl.define do
  factory :comment do
    user

    body { Faker::Lorem.sentence }

    factory :lesson_comment do
      association :commentable, factory: :lesson
    end

    factory :homework_comment do
      association :commentable, factory: :homework
    end
  end
end
