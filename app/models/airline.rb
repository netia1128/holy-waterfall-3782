class Airline < ApplicationRecord
  has_many :flights
  has_many :flight_passengers, through: :flights
  has_many :passengers, through: :flight_passengers

  def adult_passengers
    passengers.select("passengers.name, count(flights.id) as flight_count").distinct.where("age > ?", 18).group("passengers.name").order("flight_count desc")
  end
end
