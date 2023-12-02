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
    end
end
