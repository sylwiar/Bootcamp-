class PlaceRent < ActiveRecord::Base
  belongs_to :address
  belongs_to :owner, class_name: "Person"
  has_many :place_rents
end
