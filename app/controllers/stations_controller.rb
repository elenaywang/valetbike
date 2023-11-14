class StationsController < ApplicationController
  
  def index
    @stations = Station.all.order(identifier: :asc)
    
  end

  def pricing
  end

  def sign_up
  end
 
  def log_in
  end

  def help
  end

  def explore
  end

  def pricing
  end

  def sign_up
  end
 
  def log_in
  end

  def help
  end

  def explore
  end
  
end
