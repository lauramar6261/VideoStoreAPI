class ApplicationController < ActionController::API
  require 'will_paginate/array'

  before_action :sort_param, :page_param, :num_page_param

  private

  def sort_array(array, keyword_array)
    return array.sort_by{|cust| cust.send(sort_param)} if sort_param && sort_param.in?(keyword_array)
    return array
  end

  def paginate_array(array)
    page_param ||= 1
    return array.paginate(:page => page_param, :per_page => num_page_param) if page_param && num_page_param
    return array
  end

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
