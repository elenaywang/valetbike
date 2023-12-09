class RentalsController < ApplicationController
  before_action :authenticate_user!     # forces user to log in before renting a bike
  before_action :set_rental, only: [:show, :edit, :update]
  before_action :set_station, :ask_for_payment, :prevent_multi_rentals, :station_has_bikes, only: [:new, :create]
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
  end

  def edit
  end

  def update
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

  def set_rental
    @rental = Rental.find(params[:id])
  end

  # checks if current user has no rentals that have not been returned yet
  def prevent_multi_rentals
    unless current_user.rentals.where(return: nil).empty?
      # redirects if user has an active rental that has not been returned yet
      flash[:notice] = 'Please return your current bike before renting another one.'
      @active_rental = current_user.rentals.where(return: nil).first
      redirect_to rental_path(@active_rental.id)      # redirects to currently active rental
    end
  end

  # checks if the rental has already been returned
  def prevent_return_old_rental
    unless @rental.return.nil?
      # redirects if the rental has already been returned
      flash[:notice] = 'You have already returned this bike.'
      redirect_to rentals_path
    end
  end

  # checks if the station has bikes
  def station_has_bikes
    unless @station.docked_bikes.count > 0
      # redirects if the station has no bikes
      flash[:notice] = 'This station has no bikes. Please choose another station.'
      redirect_to map_home_index_path    # flash message is hard to read bc map loads on top of it; TODO: may need to change this
    end
  end

  # checks if the user has provided their payment info
  def ask_for_payment
    if current_user.payment_id.nil?
      # redirects if current user has no payment info
      flash[:notice] = 'Please input your payment information.'
      redirect_to new_user_payment_path(current_user.id)
    end
  end


end
