require 'rails_helper'

RSpec.describe Airline, type: :model do
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
    FlightPassenger.create!(flight: @flight1, passenger: @passenger2)
    FlightPassenger.create!(flight: @flight1, passenger: @passenger3)
    FlightPassenger.create!(flight: @flight1, passenger: @passenger4)
    FlightPassenger.create!(flight: @flight2, passenger: @passenger1)
    FlightPassenger.create!(flight: @flight2, passenger: @passenger2)
    FlightPassenger.create!(flight: @flight2, passenger: @passenger3)
    FlightPassenger.create!(flight: @flight2, passenger: @passenger4)
    FlightPassenger.create!(flight: @flight2, passenger: @passenger6)
  end

  it {should have_many :flights}
  it {should have_many :passengers}

  describe 'instance methods' do
    describe '#adult_passengers' do
      it 'returns the name and flight count for adult passengers on any flight for the airline with no duplicates and ordered by flight count' do
        expect(@spirit.adult_passengers[0].name).to eq(@passenger2.name)
        expect(@spirit.adult_passengers[0].flight_count).to eq(2)
        expect(@spirit.adult_passengers[1].name).to eq(@passenger1.name)
        expect(@spirit.adult_passengers[1].flight_count).to eq(1)
        expect(@spirit.adult_passengers.length).to eq(2)
      end
    end
  end
end
