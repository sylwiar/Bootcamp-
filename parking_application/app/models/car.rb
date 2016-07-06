class Car < ActiveRecord::Base
  validates :registration_number, :model, :owner, presence: true

  belongs_to :owner, class_name: "Person"
  has_many :place_rents
end