class RentalsController < ApplicationController
  before_action :authenticate_user!     # forces user to log in before renting a bike
  before_action :set_station, :prevent_mult_rentals, :station_has_bikes, only: [:new, :create]
  before_action :prevent_return_old_rental, only: [:edit, :update]   # prevent user from returning a rental that was already returned

  def index
    # users_rentals = Rental.where(borrower_id: current_user.id)
    # @rentals = users_rentals.order(:checkout)
    @rentals = current_user.rentals
  end
  
  def new
    @rental = Rental.new(checkout: DateTime.now)      # prepopulating form with current time for start of rental
  end
 
  def create
    @rental = Rental.new(rental_params)
    @random_number = "%07d" % rand(10000000)
    @rental.number = @random_number
    @rental.borrower_id = current_user.id
    @rental.station_id = @station.id

    bikes_at_station = Bike.where(current_station_id: @station.id)
    @rental.bike_id = bikes_at_station.first.id
    
   
    #and then loop over the bikes_at_station {to find the first that isn't in use:
    #   if bike belongs to a rental (bike.)}
    #and then make that bike's station null.

    #so we'd need a ruby loop that checks ea bike to see if there is a rental that owns it at that time? 
    #maybe at first we can not worry about scheduling and just do current rentals at current time.
    if @rental.save
      redirect_to rental_path(@rental)
      @bike = @rental.bike
      @bike.update(current_station_id: nil)
    else 
      #eventually need to tell you to fix error
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
      @rental.update(return: DateTime.now)
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

  def prevent_mult_rentals
    # checks if current user has no rentals that have not been returned yet
    unless current_user.rentals.where(return: nil).empty?
      # redirects if user has an active rental that has not been returned yet
      flash[:notice] = 'Please return your current bike before renting another one.'
      redirect_to rentals_path
      # @active_rental = current_user.rentals.where(return: nil)    # TODO: trying to redirect to current active rental
      # redirect_to rental_path(@active_rental)
    end
  end

  def prevent_return_old_rental
    # checks if the rental has already been returned
    @rental = Rental.find(params[:id])
    unless @rental.return.nil?
      # redirects if the rental has already been returned
      flash[:notice] = 'You have already returned this bike.'
      redirect_to rentals_path
    end
  end

  def station_has_bikes
    # checks if the station has bikes
    unless @station.docked_bikes.count > 0
      # redirects if the station has no bikes
      flash[:notice] = 'This station has no bikes. Please choose another station.'
      redirect_to map_home_index_path    # flash message is hard to read bc map loads on top of it; TODO: may need to change this
    end
  end


end
