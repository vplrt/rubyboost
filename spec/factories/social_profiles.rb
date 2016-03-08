FactoryGirl.define do
  factory :social_profile do
    user

    sequence(:uid) { |n| "12345#{n}" }
    service_name { 'twitter' }
  end
end
