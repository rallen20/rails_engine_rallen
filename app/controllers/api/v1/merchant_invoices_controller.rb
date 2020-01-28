class Api::V1::MerchantInvoicesController < ApplicationController
  def index
    merchant = Merchant.find(params[:merchant_id])
    render json: MerchantInvoiceSerializer.new(merchant.invoices)
  end
end
