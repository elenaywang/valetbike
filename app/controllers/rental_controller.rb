class RentalController < ApplicationController
  def new
    @stations = Station.all #eventaully change to...the chosen station?
    @rental = Rental.new
    @time = DateTime.now
    #sth like this too @user = User.loggedIn
  end

  def edit
  end
end
