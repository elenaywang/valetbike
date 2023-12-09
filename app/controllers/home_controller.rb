class HomeController < ApplicationController

    def index
      @stations = Station.all.order(identifier: :asc)

      respond_to do |format|
        format.html
        format.json {render json: @stations }
      end 
    end
  
    def map
      @stations = Station.all.order(identifier: :asc)

      respond_to do |format|
        format.html
        format.json {render json: @stations }
      end 
    end
  
    def pricing
    end
  
    def help
    end
  
    def explore
    end

    def profile
      # defines a user's currently active rental if they have one
      unless current_user.rentals.where(return: nil).empty?
        @active_rental = current_user.rentals.where(return: nil).first
      end
    end


end
