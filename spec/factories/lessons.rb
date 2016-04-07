FactoryGirl.define do
  factory :lesson do
    user
    course

    title { Faker::Lorem.sentence }
    sequence(:position) { |n| n }
    description { Faker::Lorem.paragraph(2) }
    sequence(:notes) { Faker::Lorem.paragraph(2) }
    sequence(:homework) { Faker::Lorem.paragraph(2) }
    sequence(:date) { Faker::Time.forward(23, :morning) }
  end
end
