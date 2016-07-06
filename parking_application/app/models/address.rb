class Address < ActiveRecord::Base
  validates :city, :street, presence: true
  validates :zip_code, presence: true, format: { with: /\A\d{2}-\d{3}\z/ }

  has_one :parking
end
