require 'faker'

User.create!(
  email: '1@1.ru',
  password: '11111111',
  password_confirmation: '11111111'
)

12.times do
  Course.create!(
    title: Faker::Lorem.sentence(1),
    user_id: 1
  )
end
