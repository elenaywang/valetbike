Rails.application.routes.draw do
  # get 'rental/new' #, to 'rental#new', as 'rental'
  # get 'rental/create'
  # get 'rental/code'
  resources :rentals
  root to: "stations#index"
  resources :stations

  #Adding route for the code generating page
  match 'code', to: "rentals#code", via: :get



end