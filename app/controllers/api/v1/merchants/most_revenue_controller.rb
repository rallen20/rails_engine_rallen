class Api::V1::Merchants::MostRevenueController < ApplicationController
  def index
    merchants = Merchant.joins(invoices: [:invoice_items, :transactions])
                        .select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue")
                        .group(:id)
                        .where(transactions: {result: 'success'})
                        .order('total_revenue DESC')
                        .limit(params[:quantity])
    render json: MerchantSerializer.new(merchants)
  end
end
