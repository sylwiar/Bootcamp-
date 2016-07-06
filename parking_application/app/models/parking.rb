class Parking < ActiveRecord::Base
  validates :places, presence: true
  validates :hour_price, :day_price, presence: true, numericality: true
  validates :kind, inclusion: { in: %w(outdoor indoor private street) }

  belongs_to :address
  belongs_to :owner, class_name: "Person"
  has_many :place_rents
end
