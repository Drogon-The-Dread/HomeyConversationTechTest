# frozen_string_literal: true

require 'faker'

2.times do |count|
  User.create(
    email: "user#{count}@homey.co.uk",
    password: 'password',
    name: "User #{count}"
  )
end

5.times do
  Project.create(
    owner: User.first,
    name: Faker::Company.catch_phrase,
    description: Faker::Lorem.paragraph(sentence_count: 2)
  )
end

Project.all.each do |project|
  project.start
  project.add_user_comment User.order('RANDOM()').first, Faker::Lorem.paragraph(sentence_count: 2)
  project.suspend
end
