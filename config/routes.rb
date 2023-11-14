Rails.application.routes.draw do
  # get 'rental/new' #, to 'rental#new', as 'rental'
  # get 'rental/create'
  # get 'rental/code'
  resources :rentals
  root to: "stations#index"
  resources :stations

  #Adding route for the pricing page
  match 'pricing', to: "stations#pricing", via: :get

  #Adding route for the sign up page.
  match 'sign_up', to: "stations#sign_up", via: :get

  #Adding route for the log in page. 
  match 'log_in', to: "stations#log_in", via: :get

  #Adding route for the help page
  match 'help', to: "stations#help", via: :get

  #Adding route for the explore page
  match 'explore', to: "stations#explore", via: :get

  get 'stations/index'
  get 'stations/pricing'
  get 'stations/explore'

end