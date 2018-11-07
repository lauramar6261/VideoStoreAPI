class MoviesController < ApplicationController

  def current
    movie = Movie.find_by(id: params[:id])
     #due date #checkout date #customer id
    # info <<  Movie.find_by(id: params[:id]).rentals.where(active:true) #name #postal_code
    if movie
      rentals = movie.rentals.where(active:true)
      if rentals
        current_checkout = []
        rentals.each do |rental|
          customer = rental.customer
          current_checkout << {
              "customer_id" => customer.id,
              "name" => customer.name,
              "postal_code" => customer.postal_code,
              "checkout_date" => rental.checkout_date,
              "due_date" => rental.due_date
          }
          end
        current_checkout = sort_array(current_checkout, %w(current_id name postal_code checkout_date due_date))
        current_checkout = paginate_array(current_checkout)
        render json: current_checkout.as_json, status: :ok
      else
      render json: {"errors": {"movie": ['has not been checked out']}}, status: :not_found
      end
    else
      render json: {"errors": {"movie": ['movie does not exitst']}}, status: :not_found
    end
  end

  def index
    movies = Movie.all
    render json: movies.as_json(only: [:id, :title, :release_date]), status: :ok
  end

  def show
    movie = Movie.find_by(id: params[:id])

    if movie
      render json: movie.as_json(only: [:title, :overview, :release_date, :inventory, :available_inventory]), status: :ok
    else
      render json: {"errors": {"movie": ['movie not found']}}, status: :not_found
    end
  end

  def create
    movie = Movie.new(movie_params)

    if movie.save
      render json: movie.as_json(only: [:id]), status: :ok
    else
      render json: {"errors": {"movie": movie.errors.messages}}, status: :bad_request
    end

  end

  def zomg
    render json: {message: "it works!"}, status: :ok
  end

private

  def movie_params
    params.permit(:title, :overview, :release_date, :inventory, :id)
  end
end
