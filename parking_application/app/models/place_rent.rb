class PlaceRent < ActiveRecord::Base
  belongs_to :parking
  belongs_to :car
  has_many :people
end
