class PlaceRent < ActiveRecord::Base
  validates :start_date, :end_date, :car, presence: true

  belongs_to :parking
  belongs_to :car
  has_many :people
end
