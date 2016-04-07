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

user_2 = User.create!(
  email: '2@2.ru',
  password: '11111111',
  password_confirmation: '11111111'
)

Profile.create!(
  first_name: Faker::Name.first_name,
  last_name:  Faker::Name.last_name,
  user: user_2
)

12.times do
  Course.create!(
    title: Faker::Lorem.sentence(1),
    user: user
  )
end

3.times do
  Lesson.create!(
    title: Faker::Lorem.sentence(1),
    position: 1,
    description: Faker::Lorem.paragraph(2),
    notes: Faker::Lorem.paragraph(2),
    homework: Faker::Lorem.paragraph(2),
    user: user,
    course: Course.last,
    date: Faker::Time.forward(23, :morning)
  )
end
