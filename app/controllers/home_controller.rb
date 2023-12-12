class HomeController < ApplicationController
  before_action :authenticate_user!, only: [:profile]

    before_action :set_active_rental, only: [:map, :profile]    # defines a user's currently active rental if they have one
    
    def index
      if params[:station].present?
        @stations = Station.near(params[:station])
      else
        @stations = Station.all.order(identifier: :asc)
      end
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
    end

    private

    # defines a user's currently active rental if they have one
    def set_active_rental
      if user_signed_in? && !current_user.rentals.where(return: nil).empty?
        @active_rental = current_user.rentals.where(return: nil).first
      end
    end


end
