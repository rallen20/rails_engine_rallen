class Api::V1::Merchants::FavoriteCustomerController < ApplicationController
  def show
    customer = Customer.favorite_customer(params["merchant_id"])
    render json: CustomerSerializer.new(customer.first)
  end
end
