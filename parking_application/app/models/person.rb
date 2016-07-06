class Person < ActiveRecord::Base
  validates :first_name, presence: true

  has_many :parkings
  has_many :cars
end
