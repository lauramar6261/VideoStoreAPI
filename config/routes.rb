Rails.application.routes.draw do
  post '/rentals/check-out', to: 'rentals#checkout', as: 'checkout'
  post '/rentals/check-in', to: 'rentals#checkin', as: 'checkin'
  get '/rentals/overdue', to: 'rentals#overdue', as: 'overdue'
  get '/movies', to: 'movies#index', as: 'movies'
  post '/movies', to: 'movies#create'
  get '/movies/:id', to: 'movies#show', as: 'movie'
  get '/customers', to: 'customers#index', as: 'customers'
  get '/customers/:id/current', to: 'customers#current', as: 'customer_current'
  get '/customers/:id/history', to: 'customers#history', as: 'customer_history'
  get '/zomg', to: 'movies#zomg', as: 'zomg'
  get '/movies/:id/current', to: 'movies#current', as: 'current'
  get '/movies/:id/history', to: 'movies#history', as: 'history'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
