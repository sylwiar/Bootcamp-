class Parking < ActiveRecord::Base
  kinds = %w(outdoor indoor private street)

  before_destroy :finish_rental

  validates :places, presence: true
  validates :hour_price, :day_price, presence: true, numericality: true
  validates :kind, inclusion: { in: kinds }

  belongs_to :address
  belongs_to :owner, class_name: "Person"
  has_many :place_rents

  accepts_nested_attributes_for :address

  scope :public_parkings, -> { where( kind: "street" ) }
  scope :private_parkings, -> { where( kind: "private" ) }
  scope :day_price_between, -> (lower_limit, upper_limit) { where( "day_price > ? and day_price < ?", lower_limit, upper_limit ) }
  scope :hour_price_between, -> (lower_limit, upper_limit) { where( "hour_price > ? and hour_price < ?", lower_limit, upper_limit ) }
  scope :in_city, -> (city) { where( "city = ?", city ).joins(:address) }

  private
  def finish_rental
    end_date = Time.now    
  end
end