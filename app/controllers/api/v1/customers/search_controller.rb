class Api::V1::Customers::SearchController < ApplicationController
  def show
    customer = Customer.find_by(request.query_parameters)
    render json: CustomerSerializer.new(customer)
  end

  def index
    customers = Customer.where(request.query_parameters).order(:id)
    render json: CustomerSerializer.new(customers)
  end
end
