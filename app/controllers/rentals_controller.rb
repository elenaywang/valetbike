class RentalsController < ApplicationController
  def new
    #@stations = Station.all #eventaully change to...the chosen station?
    @rental = Rental.new
    #@time = DateTime.now
    #sth like this too @user = User.loggedIn
  end

  def create
    @rental = Rental.new(params.require(:rental).permit(:datetime_local_field))
    Rails.logger.debug "calling create"
    if @rental.save
      redirect_to @rental, notice: "rental was successfully submitted"
    else 
      #eventually need to change this to give you the form again and tell you to fix it
      redirect_to stations_path
    end
  end

  def edit

  end

  def code

  end
end
