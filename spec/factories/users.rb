FactoryGirl.define do
  factory :user do
    email    { Faker::Internet.email }
    password { '11111111' }
  end
end
