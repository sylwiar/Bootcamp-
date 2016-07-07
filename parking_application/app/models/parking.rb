class Parking < ActiveRecord::Base
  kinds = %w(outdoor indoor private street)

  validates :places, presence: true
  validates :hour_price, :day_price, presence: true, numericality: true
  validates :kind, inclusion: { in: kinds }

  belongs_to :address
  belongs_to :owner, class_name: "Person"
  has_many :place_rents
end