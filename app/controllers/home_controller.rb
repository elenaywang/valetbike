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
    end
end
