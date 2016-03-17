FactoryGirl.define do
  factory :homework do
    user
    lesson

    body 'MyText'
  end
end
