# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#require 'ffaker'

case Rails.env
when "development"
  $stderr.puts "Seeding for rails #{Rails.env}"
  track = Hash.new

  Client.delete_all
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

  uu = User.find_by_email('sok@hell.com')
  if uu
    $stderr.puts "user sok already defined"
  else
    $stderr.puts "seeding user sok"
    uu = User.new({name: "saint of killers", email: 'sok@hell.com', password: "tummyache", password_confirmation: "tummyache"})
    uu.skip_confirmation!
    uu.save
  end

  vc = VideoCategory.find_by(:category => "any")
  if vc
    $stderr.puts "Video Category any already defined"
  else
    $stderr.puts "seeding video category any"
    VideoCategory.create({:category=>"any", :description => "General Video Category"})
  end

  bs = VideoCloud.find_by(:backing_store => "local")
  if bs
    $stderr.puts "Video Backing Store local already defined"
  else
    $stderr.puts "seeding video backing store local"
    VideoCloud.create({:backing_store => "local", :description => "Stored on local server", :access => "path/to/base/folder"}) unless bs
  end

when "test"
  $stderr.puts "Seeding for rails #{Rails.env}"

  vc = VideoCategory.find_by(:category => "any")
  if vc
    $stderr.puts "Video Category any already defined"
  else
    $stderr.puts "seeding video category any"
    VideoCategory.create({:category=>"any", :description => "General Video Category"})
  end

  bs = VideoCloud.find_by(:backing_store => "local")
  if bs
    $stderr.puts "Video Backing Store local already defined"
  else
    $stderr.puts "seeding video backing store local"
    VideoCloud.create({:backing_store => "local", :description => "Stored on local server", :access => "path/to/base/folder"}) unless bs
  end

when "production"
  $stderr.puts "Seeding for rails #{Rails.env}"

  vc = VideoCategory.find_by(:category => "any")
  if vc
    $stderr.puts "Video Category any already defined"
  else
    $stderr.puts "seeding video category any"
    VideoCategory.create({:category=>"any", :description => "General Video Category"})
  end

  bs = VideoCloud.find_by(:backing_store => "local")
  if bs
    $stderr.puts "Video Backing Store local already defined"
  else
    $stderr.puts "seeding video backing store local"
    VideoCloud.create({:backing_store => "local", :description => "Stored on local server", :access => "path/to/base/folder"}) unless bs
  end
else
  $stderr.puts "Rails.env unknown: #{Rails.env}, data seed failed." 
end
