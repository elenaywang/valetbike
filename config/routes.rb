Rails.application.routes.draw do

  resources :rentals
  resources :stations do 
    resources :rentals, only: [:new, :create]
  end
  
  resources :home do
    collection do
      get 'pricing'
      get 'explore'
      get 'map'
      get 'help'
      get 'profile'
    end
  end

  devise_for :users
  resources :users do
    resources :payments
  end

  root to: "home#index"

  
  # match 'map', to: "home#map", via: :get
  
  # #Adding route for the pricing page
  # match 'pricing', to: "home#pricing", via: :get

  # #Adding route for the help page
  # match 'help', to: "home#help", via: :get

  # #Adding route for the explore page
  # match 'explore', to: "home#explore", via: :get


  # get 'home/index'
  # get 'home/pricing'
  # get 'home/explore'
  # get 'home/map'

end
