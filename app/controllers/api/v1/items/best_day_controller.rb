class Api::V1::Items::BestDayController < ApplicationController
  def show
    render json: DateSerializer.new(Item.find(params["item_id"]))
  end
end
