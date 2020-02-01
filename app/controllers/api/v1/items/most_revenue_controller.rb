class Api::V1::Items::MostRevenueController < ApplicationController
  def index
    items = Item.most_revenue_variable(params["quantity"])
    render json: ItemSerializer.new(items)
  end
end
