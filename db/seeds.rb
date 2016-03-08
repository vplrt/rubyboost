require 'faker'

User.create!(
  email: '1@1.ru',
  password: '11111111',
  password_confirmation: '11111111'
)

Profile.create!(
  first_name: Faker::Name.first_name,
  last_name:  Faker::Name.last_name,
  user_id: 1
)

12.times do
  Course.create!(
    title: Faker::Lorem.sentence(1),
    user_id: 1
  )
end
