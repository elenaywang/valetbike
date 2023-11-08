class RentalController < ApplicationController
  def new
    @stations = Station.all
    @task = Task.new
  end

  def edit
  end
end
