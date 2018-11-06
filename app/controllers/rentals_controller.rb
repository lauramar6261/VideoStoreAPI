class RentalsController < ApplicationController
  def checkout
    movie = Movie.find_by(id: rental_params[:movie_id])
    customer = Customer.find_by(id: rental_params[:customer_id])
    checkout_date = DateTime.now
    due_date = checkout_date + 7
    rental = Rental.new
    rental.customer = customer
    rental.checkout_date = checkout_date
    rental.due_date = due_date
    rental.movie = movie

    if rental.save
      render json: rental.as_json(only: [:id]), status: :ok
    else
      render json: {ok: false, message: rental.errors.messages}, status: :bad_request
    end
  end

  def checkin
  end

  def rental_params
    params.permit(:customer_id, :movie_id)
  end
end
