class Person < ActiveRecord::Base
  has_many :parkings
  has_many :cars
end
