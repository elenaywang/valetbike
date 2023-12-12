class RentalsController < ApplicationController
  before_action :authenticate_user!     # forces user to log in before renting a bike
  before_action :set_rental, only: [:show, :edit, :update]
  before_action :set_station, only: [:new, :create, :edit]
  before_action :ask_for_payment, :prevent_multi_rentals, :station_has_bikes, only: [:new, :create]
  before_action :user_access, only: [:edit, :update, :show, :prevent_return_old_rental]
  before_action :prevent_return_old_rental, only: [:edit, :update]   # prevent user from returning a rental that was already returned
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
      checkout_station: @station,
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
  end

  def edit
    @rental.update(return_station_id: @station.id)
  end

  def update
    if @rental.update(rental_params)
      @rental.update(return: @current_time)
      @rental.update(cost: @rental.duration*0.05) #one day rate should not be hard coded :)
      bike = @rental.bike
      bike.update(current_station_id: @rental.return_station_id)
      redirect_to rental_path(@rental)
    else
      render('edit')
    end
  end

  private

  def rental_params
    params.require(:rental).permit(:checkout, :station_id, :return_station_id, :return, :checkout_station, :return_station)
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
    @payment = Payment.find_by(user_id: current_user.id)
    if @payment.nil?
      # redirects if current user has no payment info
      flash[:notice] = 'Please input your payment information.'
      redirect_to new_user_payment_path(current_user.id)
    end
  end

  def current_time
    @current_time = Time.now
  end

  def user_access
    @rental = Rental.find(params[:id])
    if @rental.borrower != current_user
      flash[:notice] = "Cannot access rentals made by other users"
      redirect_to rentals_path
    end
  end
    

end