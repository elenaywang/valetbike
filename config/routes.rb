Rails.application.routes.draw do

  # get 'rental/new' #, to 'rental#new', as 'rental'
  # get 'rental/create'
  # get 'rental/code'
  resources :rentals
  resources :stations


  devise_for :users
  root to: "home#index"
  
  match 'map', to: "home#map", via: :get
  
  #Adding route for the pricing page
  match 'pricing', to: "home#pricing", via: :get

  #Adding route for the help page
  match 'help', to: "home#help", via: :get

  #Adding route for the explore page
  match 'explore', to: "home#explore", via: :get


  get 'home/index'
  get 'home/pricing'
  get 'home/explore'
  get 'home/map'

end
