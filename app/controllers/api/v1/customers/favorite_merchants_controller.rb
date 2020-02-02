class Api::V1::Customers::FavoriteMerchantsController < ApplicationController
  def show
    merchant = Merchant.favorite_merchant(params["customer_id"])
    render json: MerchantSerializer.new(merchant.first)
  end
end
