class Api::V1::Merchants::MostRevenueController < ApplicationController
  def index
    merchants = Merchant.most_revenue_variable(params[:quantity])
    render json: MerchantSerializer.new(merchants)
  end
end
