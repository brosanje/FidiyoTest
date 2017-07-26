require 'rails_helper'


feature 'Client Search' do
  def create_test_user(email: , password: )
    ## password: "qw3rtyu1oPP"
    uu = User.new({name: "Fred Pickle", email: email, password: password, password_confirmation: password})
    uu.skip_confirmation!
    uu.save
  end

  let(:email)    { "pat@example.com" }
  let(:password) { "qw3rtyu1oPP" }
  let(:track_username) { Hash.new }
  let(:ii) { 0 }

  def create_client(main_contact:, name: nil, email: nil)
    #username = "#{Faker::Internet.user_name}#{rand(1000)}"
    username = Faker::Internet.user_name
    if track_username.has_key?(username)
      ii += 1
      track_username[username] += 1
      username += ii.to_s
    else
      track_username[username] = 1
    end

    ##email ||= "#{username}#{rand(1000)}@" +
    ##             "#{Faker::Internet.domain_name}"
    email ||= "#{Faker::Internet.user_name}#{ii}@#{Faker::Internet.domain_name}"
    name ||= Faker::Company.name
    main_contact ||= Faker::Name.name

    Client.create!(
      username: username,
      email: email,
      name: name,
      main_contact: main_contact,
      address: "#{Faker::Address.street_name}, #{Faker::Address.secondary_address}, #{Faker::Address.city}, #{Faker::Address.state_abbr}, #{Faker::Address.country}, #{Faker::Address.postcode}",
      phone: Faker::PhoneNumber.cell_phone,
      logo: Faker::HitchhikersGuideToTheGalaxy.quote,
      status: Faker::Color.color_name,
    )
  end

  before do
    create_test_user(email: email, password: password)

    create_client main_contact: "Chris Aaron"
    create_client main_contact: "Pat Johnson"
    create_client main_contact: "I.T. Pat"
    create_client main_contact: "Patricia Dobbs"

    # This user is the one we'll expect to be listed first
    create_client main_contact: "Pat Jones", email: "pat123@somewhere.net"
  end
  
  scenario "Search by Name"do
    visit "/clients"

    # Login to get access to /customers
    fill_in "Email",    with: email
    fill_in "Password", with: password
    click_button "Log in"

    within "section.search-form" do
      fill_in "keywords", with: "pat"
    end

    within "section.search-results" do
      expect(page).to have_content("Results")
      expect(page.all("ol li.list-group-item").count).to eq(4)

      list_group_items = page.all("ol li.list-group-item")

      expect(list_group_items[0]).to have_content("Patricia")
      expect(list_group_items[0]).to have_content("Dobbs")
      expect(list_group_items[3]).to have_content("I.T.")
      expect(list_group_items[3]).to have_content("Pat")
    end
  end

  scenario "Search by Email" do
    visit "/clients"

    # Login to get access to /customers
    fill_in "Email",    with: email
    fill_in "Password", with: password
    click_button "Log in"

    within "section.search-form" do
      fill_in "keywords", with: "pat123@somewhere.net"
    end
    within "section.search-results" do
      expect(page).to have_content("Results")
      expect(page.all("ol li.list-group-item").count).to eq(4)

      list_group_items = page.all("ol li.list-group-item")

      expect(list_group_items[0]).to have_content("Pat")
      expect(list_group_items[0]).to have_content("Jones")
      expect(list_group_items[1]).to have_content("Patricia")
      expect(list_group_items[1]).to have_content("Dobbs")
      expect(list_group_items[3]).to have_content("I.T.")
      expect(list_group_items[3]).to have_content("Pat")
    end
  end

end
