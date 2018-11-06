class CustomersController < ApplicationController
  def index
    customers = Customer.all

    sort_param = params[:sort]
    customers = customers.sort_by{|cust| cust.send(sort_param)} if sort_param && sort_param.in?(%w(name registered_at postal_code))

    if customers.nil?
      render json: {"errors": {"customer": ["Customer not found"]}}, status: :not_found
    else
      render json: customers.as_json(only: [:id, :name, :registered_at, :postal_code, :phone], methods: [:movies_checked_out_count]), status: :ok
    end
  end
end
