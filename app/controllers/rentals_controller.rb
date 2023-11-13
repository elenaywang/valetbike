class RentalsController < ApplicationController
  def index
    @rentals = Rental.order(:checkout)
  end
  
  def new
    #@stations = Station.all #eventaully change to...the chosen station?
    @rental = Rental.new
    #@time = DateTime.now
    #sth like this too @user = User.loggedIn
  end

  def create
    @rental = Rental.new(rental_params)
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

  def code

  end

  private
  def rental_params
    params.require(:rental).permit(:checkout, :bike_id)
  end
end
