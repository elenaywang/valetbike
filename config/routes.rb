Rails.application.routes.draw do
  # get 'rental/new' #, to 'rental#new', as 'rental'
  # get 'rental/create'
  # get 'rental/code'
  resources :rentals
  root to: "stations#index"
  resources :stations



end