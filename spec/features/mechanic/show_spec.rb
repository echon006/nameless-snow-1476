require 'rails_helper'

RSpec.describe 'the mechanics show page' do
  before :each do
    @park_1 = AmusementPark.create!(name: "Park 1", admission_cost: 25)
    @park_2 = AmusementPark.create!(name: "Park 2", admission_cost: 30)

    @ride_1 = @park_1.rides.create!(name: "Ride 1", thrill_rating: 7, open: false )
    @ride_2 = @park_1.rides.create!(name: "Ride 2", thrill_rating: 8, open: true )
    @ride_3 = @park_2.rides.create!(name: "Ride 3", thrill_rating: 9, open: true )
    @ride_4 = @park_2.rides.create!(name: "Ride 4", thrill_rating: 10, open: false )

    @mechanic_1 = Mechanic.create!(name: "Mech 1", years_experience: 5)
    @mechanic_2 = Mechanic.create!(name: "Mech 2", years_experience: 10)
    @mechanic_3 = Mechanic.create!(name: "Mech 3", years_experience: 15)
    @mechanic_4 = Mechanic.create!(name: "Mech 4", years_experience: 20)

    MechanicRide.create!(ride: @ride_1, mechanic: @mechanic_1)
    MechanicRide.create!(ride: @ride_2, mechanic: @mechanic_1)
    MechanicRide.create!(ride: @ride_3, mechanic: @mechanic_1)
    MechanicRide.create!(ride: @ride_4, mechanic: @mechanic_1)
  end

  it "shows a specific mechanic and their attributes " do
    visit "/mechanics/#{@mechanic_1.id}"

    expect(page).to have_content(@mechanic_1.name)
    expect(page).to have_content(@mechanic_1.years_experience)
  end

  it "shows the rides they work on" do
    visit "/mechanics/#{@mechanic_1.id}"
    expect(page).not_to have_content(@ride_1.name)
    expect(page).to have_content(@ride_2.name)
    expect(page).to have_content(@ride_3.name)
  end

  
end
