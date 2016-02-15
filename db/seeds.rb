require 'faker'

12.times do
  Course.create! title: Faker::Lorem.sentence(1)
end
