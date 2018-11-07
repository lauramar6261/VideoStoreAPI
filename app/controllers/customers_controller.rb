class CustomersController < ApplicationController
  def index
    customers = Customer.all

    customers = sort_array(customers, %w(name registered_at postal_code))

    # customers = customers.sort_by{|cust| cust.send(sort_param)} if sort_param && sort_param.in?(%w(name registered_at postal_code))
    # customers = customers.paginate(:page => page_param, :per_page => num_page_param) if page_param && num_page_param
    customers = paginate_array(customers)

    if customers.nil?
      render json: {"errors": {"customer": ["Customer not found"]}}, status: :not_found
    else
      render json: customers.as_json(only: [:id, :name, :registered_at, :postal_code, :phone], methods: [:movies_checked_out_count]), status: :ok
    end
  end

  def current
    customer = Customer.find_by(id: params[:id])

    if customer
      rentals = Rental.where("rentals.active = ? and rentals.customer_id = ?", true, customer.id)
      if rentals.any?
        rental_summary = []
        rentals.each do |rental|
          rental_summary << {
            "title" => rental.movie.title,
            "checkout_date" => rental.checkout_date,
            "due_date" => rental.due_date
          }
        end

        rental_summary = sort_array(rental_summary, %w(title checkout_date due_date))
        rental_summary = paginate_array(rental_summary)

        render json: rental_summary.as_json, status: :ok

      else
        render json: {"errors": {"customer": ["No current rentals"]}}, status: :not_found
      end

    else
      render json: {"errors": {"customer": ["Customer not found"]}}, status: :not_found
    end

  end
end
