class CarRentalsController < ApplicationController

  def new
    @rental = Rental.find(params[:rental_id])
    @car_rental = CarRental.new
    @cars = @rental.car_category.cars
  end

  def create
    @rental = Rental.find(params[:rental_id])
    @car_rental = CarRental.new(params_car_rental)
    @car_rental.user = current_user
    @car_rental.rental = @rental
    @car_rental.save!
    @rental.ongoing!

    redirect_to @rental
  end

  private

  def params_car_rental
    params.require(:car_rental).permit(:car_id)
  end
end