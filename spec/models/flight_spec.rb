require 'rails_helper'

RSpec.describe Flight, type: :model do
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

  it {should belong_to :airline}
  it {should have_many :passengers}

  describe 'instance methods' do
    describe 'airline_name' do
      it 'should return the name of an airline for a given flight' do
        expect(@flight1.airline_name).to eq('Spirit Air')
      end
    end
    describe 'passengers' do
      it 'should return the names of all the passengers for a given flight' do
        expect(@flight1.passengers).to eq([@passenger1,
                                           @passenger2,
                                           @passenger3,
                                           @passenger4,
                                           @passenger5])
      end
    end
  end
end
