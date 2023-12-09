class RentalsController < ApplicationController
  # before_action :require_login
  before_action :set_station, only: [:new, :create]
  before_action :current_time, only: [:create, :update]


  def index
    @rentals = current_user.rentals
  end
  
  def new
    @rental = Rental.new()
    @station
  end
 
  def create
    @rental = Rental.new(
      number: "%07d" % rand(10000000),
      borrower: current_user,
      station_id: @station.id,
      bike: Bike.where(current_station_id: @station.id).first,
      checkout: @current_time)
    
    if @rental.save
      redirect_to rental_path(@rental)
      @bike = @rental.bike
      @bike.update(current_station_id: nil)
    else 
      render('new')
    end
  end

  def show
    @rental = Rental.find(params[:id])
  end

  def edit
    @rental = Rental.find(params[:id])
  end

  def update
    @rental = Rental.find(params[:id])
    if @rental.update(rental_params)
      @rental.update(return: @current_time)
      bike = @rental.bike
      bike.update(current_station_id: @rental.station_id)
      redirect_to rental_path(@rental)
    else
      render('edit')
    end


  end

  private
  def rental_params
    params.require(:rental).permit(:checkout, :station_id, :return)
  end

  def set_station
    @station = Station.find(params[:station_id])
  end

  def current_time
    @current_time = Time.now
  end

end