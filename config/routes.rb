Rails.application.routes.draw do

  # root to: "home#index"
  root to: "home#index"

  match 'map', to: "home#map", via: :get

  # resources:bikes, only: [:map]
  # resources:stations, only: [:map]
  
  get 'home/index'
  get 'home/map'
  get 'bikes/index'
  get 'bikes/_row'
  
end