class Flight < ApplicationRecord
  belongs_to :airline
  has_many :flight_passengers
  has_many :passengers, through: :flight_passengers

  def airline_name
    airline.name
  end

  def passengers
    passenger_ids = flight_passengers.pluck(:passenger_id)
    Passenger.where(id: passenger_ids)
  end
end
