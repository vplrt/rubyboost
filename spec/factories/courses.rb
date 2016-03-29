FactoryGirl.define do
  factory :course do
    user

    title { Faker::Lorem.sentence }
    visible true
  end
end
