class RentalsController < ApplicationController
  # before_action :require_login
  before_action :set_station, only: [:create]

  def index
    # users_rentals = Rental.where(borrower_id: current_user.id)
    # @rentals = users_rentals.order(:checkout)
    @rentals = current_user.rentals
  end
  
  def new
    @rental = Rental.new(checkout: DateTime.now) 
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

  def return_bike
    
  end

  def edit
    @rental = Rental.find(params[:id])
  end

  def update
    @rental = Rental.find(params[:id])
    if @rental.update(rental_params)
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

  # def require_login
  #   unless logged_in?
  #     flash[:error] = "You must be logged in to access this section"
  #     redirect_to new_login_url 
  #   end
  # end

end
