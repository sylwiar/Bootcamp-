class ParkingsController < ApplicationController
  def index
    @parkings = Parking.search(params).order(:id)
  end

  def show
    @parking = Parking.find(params[:id])
  end

  def new
    @parking = Parking.new
    @parking.build_address
  end

  def edit
    @parking = Parking.find(params[:id])
  end

  def create
    @parking = Parking.new(parking_params)
 
    if @parking.save
      redirect_to @parking
    else
      render "new"
    end
  end

  def update
    @parking = Parking.find(params[:id])
    if @parking.update(parking_params)
      redirect_to @parking
    else
      render "edit"
    end
  end

  def destroy
    @parking = Parking.find(params[:id]).destroy
    flash[:success] = "Parking deleted"
    redirect_to @parking
  end

  private

  def parking_params
    params.require(:parking).permit(:places, :kind, :hour_price, :day_price, address_attributes: [:zip_code, :street, :city ]) 
  end
end
