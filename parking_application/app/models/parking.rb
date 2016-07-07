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
  scope :day_price_between, -> (lower_day_limit, upper_day_limit) { where( "day_price > ? and day_price < ?", lower_day_limit, upper_day_limit ) }
  scope :hour_price_between, -> (lower_hour_limit, upper_hour_limit) { where( "hour_price > ? and hour_price < ?", lower_hour_limit, upper_hour_limit ) }
  scope :in_city, -> (city) { where( "city = ?", city ).joins(:address) }

  private
  def finish_rental
    end_date = Time.now    
  end

  def self.search(params)
    parkings = Parking.all
    city = params[:city]
    public_parking = params[:public_parking]
    private_parking = params[:private_parking]
    lower_hour_limit = params[:lower_hour_limit]
    upper_hour_limit = params[:upper_hour_limit]    
    lower_day_limit = params[:lower_day_limit]
    upper_day_limit = params[:upper_day_limit]
    
    parkings = parkings.in_city(city) if city.present?
    parkings = parkings.public_parkings if public_parking.present?
    parkings = parkings.private_parkings if private_parking.present?

    lower_hour_limit = "0" if lower_hour_limit.blank?
    
    if lower_hour_limit.present? && upper_hour_limit.present?  
      parkings = parkings.hour_price_between(lower_hour_limit, upper_hour_limit)
    end
    
    lower_day_limit = "0" if lower_day_limit.blank?
 
    if lower_day_limit.present? && upper_day_limit.present?  
      parkings = parkings.day_price_between(lower_day_limit, upper_day_limit)
    end

    parkings
  end
end