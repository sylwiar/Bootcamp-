class PlaceRentsController < ApplicationController
  before_action :authenticate_account!
  
  def index
    @place_rents = PlaceRent.all
  end

  def show
    @place_rent = PlaceRent.find(params[:id])
  end

  def new
    @place_rent = PlaceRent.new
    @parking = Parking.find(params[:parking_id])
  end

  def create
    @place_rent = Parking.find(params[:parking_id]).place_rents.build(place_rent_params)
 
    if @place_rent.save
      redirect_to @place_rent
    else
      render "new"
    end
  end

  private

  def place_rent_params
    params.require(:place_rent).permit(:start_date, :end_date, :car_id) 
  end
end
