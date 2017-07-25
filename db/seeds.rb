# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#require 'ffaker'

track = Hash.new

50_000.times do |ii|
  username = Faker::Internet.user_name
  if track.has_key?(username)
    track[username] += 1
    username += ii.to_s
  else
    track[username] = 1
  end

  Client.create!(
    username: username,
    email: "#{Faker::Internet.user_name}#{ii}@#{Faker::Internet.domain_name}",
    name: Faker::Company.name,
    logo: Faker::HitchhikersGuideToTheGalaxy.quote,
    main_contact: Faker::Name.name,
    address: "#{Faker::Address.street_name}, #{Faker::Address.secondary_address}, #{Faker::Address.city}, #{Faker::Address.state_abbr}, #{Faker::Address.country}, #{Faker::Address.postcode}",
    phone: Faker::PhoneNumber.cell_phone,
    status: Faker::Color.color_name,
  )

  print '.' if ii % 1000 == 0
end

puts
