class MoviesController < ApplicationController
  def index
  end

  def show
  end

  def create
  end

  def zomg
    render json: {message: "it works!"}, status: :ok
  end
end
