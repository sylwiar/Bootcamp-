class PlaceRent < ActiveRecord::Base
  before_save :calculate_price
  validates :start_date, :end_date, :car, presence: true

  belongs_to :parking
  belongs_to :car
  has_many :people

  def calculate_price
    day_spent = (end_date - start_date).to_i/3600*24
    hour_spent = (end_date - start_date).to_i%3600*24
    self.price = parking.day_price * day_spent + parking.hour_price * hour_spent
  end
end
