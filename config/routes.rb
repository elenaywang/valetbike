Rails.application.routes.draw do
  get 'rental/new'
  get 'rental/edit'
  root to: "stations#index"
  resources :stations
end