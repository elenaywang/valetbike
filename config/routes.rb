Rails.application.routes.draw do
  root to: "stations#index"

  #Adding route for the pricing page
  match 'pricing', to: "stations#pricing", via: :get

  #Adding route for the sign up page. For now I'll use the stations_controller. What are we using the application_controller for? Should I create another controller?
  match 'sign_up', to: "stations#sign_up", via: :get

  #Adding route for the log in page. For now I'll use the stations_controller.
  match 'log_in', to: "stations#log_in", via: :get
  
end