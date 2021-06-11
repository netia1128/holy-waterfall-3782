require 'rails_helper'

RSpec.describe 'show page', type: :feature do
  before(:each) do
    @spirit = Airline.create!(name: "Spirit Air")
    @flight1 = @spirit.flights.create!(number: 970, date: "June 27th, 2021", departure_city: "Denver", arrival_city: "Fort Lauderdale")
    @flight2 = @spirit.flights.create!(number: 355, date: "June 27th, 2021", departure_city: "Fort Lauderdale", arrival_city: "Denver")
    @flight3 = @spirit.flights.create!(number: 355, date: "June 27th, 2021", departure_city: "Fort Lauderdale", arrival_city: "Denver")
    @passenger1 = Passenger.create!(name: "Netia Ingram", age: "32")
    @passenger2 = Passenger.create!(name: "Panda Ingram", age: "34")
    @passenger3 = Passenger.create!(name: "Kazamir Ingram", age: "3")
    @passenger4 = Passenger.create!(name: "Dasya Ingram", age: "1")
    @passenger5 = Passenger.create!(name: "Big Bird", age: "20")
    @passenger6 = Passenger.create!(name: "Oscar the Grouch", age: "13")
    FlightPassenger.create!(flight: @flight1, passenger: @passenger1)
    FlightPassenger.create!(flight: @flight1, passenger: @passenger2)
    FlightPassenger.create!(flight: @flight1, passenger: @passenger3)
    FlightPassenger.create!(flight: @flight1, passenger: @passenger4)
    FlightPassenger.create!(flight: @flight1, passenger: @passenger5)
    FlightPassenger.create!(flight: @flight2, passenger: @passenger1)
    FlightPassenger.create!(flight: @flight2, passenger: @passenger2)
    FlightPassenger.create!(flight: @flight2, passenger: @passenger3)
    FlightPassenger.create!(flight: @flight2, passenger: @passenger4)
    FlightPassenger.create!(flight: @flight2, passenger: @passenger6)
    FlightPassenger.create!(flight: @flight3, passenger: @passenger1)
  end

  describe 'page appearance' do
    it 'lists all the adult passengers on any of the airlines flights' do
      visit "/airlines/#{@spirit.id}"

      expect(page).to have_content(@passenger1.name)
      expect(page).to have_content(@passenger2.name)
      expect(page).to_not have_content(@passenger3.name)
      expect(page).to_not have_content(@passenger4.name)
      expect(page).to have_content(@passenger5.name)
      expect(page).to_not have_content(@passenger6.name)
    end

    it 'shows flight count for each passenger and orders the passengers by flight count' do
      visit "/airlines/#{@spirit.id}"

      within "#airline-adult-passengers > tr:nth-child(3)" do
        expect(page).to have_content(@passenger1.name)
        expect(page).to have_content(3)
      end
      within "#airline-adult-passengers > tr:nth-child(4)" do
        expect(page).to have_content(@passenger2.name)
        expect(page).to have_content(2)
      end
      within "#airline-adult-passengers > tr:nth-child(5)" do
        expect(page).to have_content(@passenger5.name)
        expect(page).to have_content(1)
      end
    end
  end
end
