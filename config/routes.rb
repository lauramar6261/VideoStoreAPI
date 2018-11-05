Rails.application.routes.draw do
  post '/rentals/checkout', to: 'rentals#checkout', as: 'checkout'
  post '/rentals/checkin', to: 'rentals#checkin', as: 'checkin'
  get '/movies', to: 'movies#index', as: 'movies'
  post '/movies', to: 'movies#create'
  get '/movies/:id', to: 'movies#show', as: 'movie'
  get '/customers', to: 'customers#index', as: 'customers'
  get '/zomg', to: 'movies#zomg', as: 'zomg'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
