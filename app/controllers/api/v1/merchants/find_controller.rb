class Api::V1::Merchants::FindController < ApplicationController
  def show
    merchant = Merchant.find_by(request.query_parameters)
    render json: MerchantSerializer.new(merchant)
  end
end
