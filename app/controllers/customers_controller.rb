class CustomersController < ApplicationController
  def index
    customers = Customer.all
    if customers.nil?
      render json: {ok:false, message: 'not_found'}, status: :not_found
    else
      render json: customers.as_json(only: [:id, :name, :registered_at, :postal_code, :phone], methods: [:movies_checked_out_count]), status: :ok
    end
  end
end
