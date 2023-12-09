class HomeController < ApplicationController

    def index
    end
  
    def map
      if params[:station].present?
        @stations = Station.near(params[:station])
      else
        @stations = Station.all.order(identifier: :asc)
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
