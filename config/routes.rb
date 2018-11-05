Rails.application.routes.draw do
  get 'rentals/checkout'
  get 'rentals/checkin'
  get 'movies/index'
  get 'movies/show'
  get 'movies/create'
  get 'customers/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
