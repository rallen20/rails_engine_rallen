class Api::V1::Merchants::TotalRevenueController < ApplicationController
  def index
    total_revenue = Invoice.total_revenue_on_specific_date(params["date"])
    render json: TotalRevenueSerializer.new(TotalRevenue.new(total_revenue))
  end
end
