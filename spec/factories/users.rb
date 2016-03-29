FactoryGirl.define do
  factory :user do
    email    { Faker::Internet.email }
    password { '11111111' }

    factory :coach do
      after(:create) { |user| user.add_role(:coach) }
    end
  end
end
