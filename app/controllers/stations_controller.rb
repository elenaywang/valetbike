class StationsController < ApplicationController
  
  def index
    @stations = Station.all.order(identifier: :asc)
    @users = User.all #i can access User.all var named @user in views!
  end
  
end
