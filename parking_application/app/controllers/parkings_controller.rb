class ParkingsController < ApplicationController
  def index
    @parkings = Parking.all
  end
end
