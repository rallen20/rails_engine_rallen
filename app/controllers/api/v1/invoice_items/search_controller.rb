class Api::V1::InvoiceItems::SearchController < ApplicationController
  def show
    invoice_item = InvoiceItem.find_by(request.query_parameters)
    render json: InvoiceItemSerializer.new(invoice_item)
  end

  def index
    invoice_items = InvoiceItem.where(request.query_parameters).order(:id)
    render json: InvoiceItemSerializer.new(invoice_items)
  end
end
