require 'faker'

user = User.create!(
  email: '1@1.ru',
  password: '11111111',
  password_confirmation: '11111111'
)

user.add_role(:coach)

Profile.create!(
  first_name: Faker::Name.first_name,
  last_name:  Faker::Name.last_name,
  user: user
)

User.create!(
  email: '2@2.ru',
  password: '11111111',
  password_confirmation: '11111111'
)

Profile.create!(
  first_name: Faker::Name.first_name,
  last_name:  Faker::Name.last_name,
  user: user
)

12.times do
  Course.create!(
    title: Faker::Lorem.sentence(1),
    user: user
  )
end
