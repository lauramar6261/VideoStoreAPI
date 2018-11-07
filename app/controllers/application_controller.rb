class ApplicationController < ActionController::API
  require 'will_paginate/array'

  before_action :sort_param, :page_param, :num_page_param

  private

  def sort_param
    params[:sort]
  end

  def page_param
    if params[:p].to_i > 0
      return params[:p].to_i
    else
      return nil
    end
  end

  def num_page_param
    if params[:n].to_i > 0
      return params[:n].to_i
    else
      return nil
    end
  end
end
