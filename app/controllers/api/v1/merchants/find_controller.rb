class Api::V1::Merchants::FindController < ApplicationController
  def show
    merchant = Merchant.find_by(request.query_parameters)
    render json: MerchantSerializer.new(merchant)
  end

  def index
    merchants = Merchant.where(request.query_parameters).order(:id)
    render json: MerchantSerializer.new(merchants)
  end
end
