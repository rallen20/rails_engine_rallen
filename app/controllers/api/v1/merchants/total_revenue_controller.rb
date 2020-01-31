class Api::V1::Merchants::TotalRevenueController < ApplicationController
  def index
    total_revenue = Invoice.where(:created_at => Time.zone.parse(params["date"])..Time.zone.parse(params["date"]).next_day)
                           .joins(:invoice_items, :transactions)
                           .where("transactions.result = 'success'")
                           .sum('invoice_items.quantity * invoice_items.unit_price')
    total_revenue_object = TotalRevenue.new(total_revenue)
    render json: TotalRevenueSerializer.new(total_revenue_object)
  end
end
