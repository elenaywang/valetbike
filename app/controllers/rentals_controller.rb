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
    # @rental = Rental.new(rental_params)
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

  def return_bike
    
  end

  def edit
    @rental = Rental.find(params[:id])
  end

  def update
    @rental = Rental.find(params[:id])
    if @rental.update(rental_params)
    #rentalLength =  @current_time - @rental.checkout
    puts "**********************\n\n\n\n"
    puts @current_time - @rental.checkout 
    puts @rental.checkout
    puts @current_time
    puts rentalLength
    puts "\n\n\n\n**********************"
      @rental.update(
        return: @current_time,
        rentalLength: rentalLength,
        cost: rentalLength*0.05) #eventually need to make the 5 cents not hard coded! If Chris defines it somewhere
      redirect_to rental_path(@rental)
      @bike = @rental.bike
      @bike.update(current_station_id: @rental.station_id)
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
    @current_time = DateTime.now
  end

end