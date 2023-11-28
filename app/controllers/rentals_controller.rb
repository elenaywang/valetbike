class RentalsController < ApplicationController
  def index
    @rentals = Rental.order(:checkout)
  end
  
  def new
    @station = Station.find(params[:station_id])
    @rental = Rental.new(checkout: DateTime.now, station_id: @station.id) 
  end
 
  def create
    @rental = Rental.new(rental_params)
    @random_number = "%07d" % rand(10000000)
    @rental.number = @random_number
    @rental.borrower_id = current_user.id
    if @rental.save
      redirect_to rental_path(@rental)
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
end
