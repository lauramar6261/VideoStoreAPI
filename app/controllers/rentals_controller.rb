class RentalsController < ApplicationController
  def checkout
    movie = Movie.find_by(id: rental_params[:movie_id])

    if !movie
      render json: {"errors": {"movie": ["Movie not found"]}}, status: :not_found

    else
      customer = Customer.find_by(id: rental_params[:customer_id])
      if !customer
        render json: {"errors": {"customer": ["Customer not found"]}}, status: :not_found
      else
        checkout_date = Date.today
        due_date = checkout_date + 7
        rental = Rental.new(customer: customer, checkout_date: checkout_date, due_date: due_date, movie: movie)

        if rental.movie.available_inventory > 0
            if rental.save
              rental.movie.available_inventory -= 1
              if !rental.movie.save
                render json: {"errors": {"movie": rental.movie.errors.messages}}, status: :bad_request
              else
                render json: rental.as_json(only: [:id]), status: :ok
              end
            else
              render json: {"errors": {"movie": rental.errors.messages}}, status: :bad_request
            end
        else
          render json: {"errors": {"movie": ["#{movie.title} is out of stock"]}}, status: :bad_request
        end
      end
    end
  end

  def checkin
    rental = Rental.find_by(movie_id: rental_params[:movie_id], customer_id: rental_params[:customer_id])
    if rental
      rental.active = false
      if rental.save
        rental.movie.available_inventory += 1
        rental.movie.save
        render json: rental.as_json(only: [:id]), status: :ok
      else
        render json: {"errors": {"rental": rental.errors.messages}}, status: :bad_request
      end
    else
      render json: {"errors": {"rental": "rental not found"}}, status: :bad_request
    end
  end

  def overdue
    rentals = Rental.where(["active = ? and due_date < ?", true, Date.today])

    if rentals.any?
      overdues = []
      rentals.each do |rental|
        movie = rental.movie
        customer = rental.customer
        overdues << {
            "movie_id" => movie.id,
            "title" => movie.title,
            "customer_id" => customer.id,
            "name" => customer.name,
            "postal_code" => customer.postal_code,
            "checkout_date" => rental.checkout_date,
            "due_date" => rental.due_date
        }
      end

      overdues = sort_array(overdues, %w(movie_id title customer_id name postal_code checkout_date due_date))
      overdues = paginate_array(overdues)
      render json: overdues.as_json, status: :ok
    else
      render json: {"errors": {"overdues": "no overdues found"}}
    end

  end

private
  def rental_params
    params.permit(:customer_id, :movie_id)
  end

end
