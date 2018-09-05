# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Start Seeding users...."
10.times do |i|
  name = Faker::Name.name
  user = User.new(
    name: name,
    email: Faker::Internet.email(name),
    password: "000000",
    title: [ Faker::Hobbit.character,Faker::Hobbit.location ].sample,
    bio: Faker::Lorem.sentence,
    location: "#{Faker::Address.city}, " + "#{Faker::Address.country}"
  )
  user.save
  user.tweets.create(body: Faker::Matz.quote)
  p user
end
puts "......The End....."
