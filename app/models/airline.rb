class Airline < ApplicationRecord
  has_many :flights
  has_many :flight_passengers
  has_many :passengers, through: :flight_passengers
end
