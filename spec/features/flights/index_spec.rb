require 'rails_helper'

RSpec.describe 'invoices index page', type: :feature do
  before(:each) do
    @spirit = Airline.create!(name: "Spirit Air")
    @flight1 = @spirit.flights.create!(number: 970, date: "June 27th, 2021", departure_city: "Denver", arrival_city: "Fort Lauderdale")
    @flight2 = @spirit.flights.create!(number: 355, date: "June 27th, 2021", departure_city: "Fort Lauderdale", arrival_city: "Denver")
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
  end

  describe 'page appearance' do
    it 'has a list of all flight numbers' do
      visit '/flights'

      expect(page).to have_content(@flight1.number)
      expect(page).to have_content(@flight2.number)
    end
    it 'next to each flight number I see the name of the Airline of that flight' do
      visit '/flights'

      expect(page).to have_content(@spirit.name)
    end
    it 'next to each flight number I see the names of all that flights passengers' do
      visit '/flights'
      # save_and_open_page

      within "#flight-index > tr:nth-child(3)" do
        expect(page).to have_content(@passenger1.name)
        expect(page).to have_content(@passenger2.name)
        expect(page).to have_content(@passenger3.name)
        expect(page).to have_content(@passenger4.name)
        expect(page).to have_content(@passenger5.name)
        expect(page).to_not have_content(@passenger6.name)
      end
    end
  end

  describe 'page functionality' do
    it 'has a link next to each passenger that allows you to remove them from the flight
        the page should redirect to the flights index once you remove a passanger
        and although the passenger should be removed from the flight, the passenger object should still exist' do
      visit '/flights'

      within "#flight-index > tr:nth-child(3)" do
        expect(page).to have_content(@passenger5.name)
        click_link('Remove Big Bird')
      end

      expect(current_path).to eq('/flights')

      within "#flight-index > tr:nth-child(3)" do
        expect(page).to have_content(@passenger1.name)
        expect(page).to have_content(@passenger2.name)
        expect(page).to have_content(@passenger3.name)
        expect(page).to have_content(@passenger4.name)
        expect(page).to_not have_content(@passenger5.name)
      end

      expect(@passenger5.name).to eq('Big Bird')
    end
  end

end
