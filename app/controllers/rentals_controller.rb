class RentalsController < ApplicationController
  before_action :authenticate_user!

  def index
    @rentals = Rental.order(:checkout)
  end
  
  def new
    @station = Station.find(params[:station_id])
    @rental = Rental.new(checkout: DateTime.now, station_id: @station.id) 
  end
 
  def create
    @rental = Rental.new(rental_params)
    #Rental.code
    @random_number = "%07d" % rand(10000000)
    @rental.number = @random_number
    @rental.borrower_id = current_user.id
    if @rental.save
      redirect_to rentals_path 
    else 
      #eventually need to tell you to fix error
      render('new')
    end
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
    params.require(:rental).permit(:checkout, :station_id)
  end
end
