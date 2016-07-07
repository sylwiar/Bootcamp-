class PlaceRentsController < ApplicationController
  def index
    @place_rents = PlaceRent.all
  end

  def show
    @place_rent = PlaceRent.find(params[:id])
  end

  private

  def place_rent_params
    params.require(:place_rent).permit(:start_date, :end_date) 
  end
end
