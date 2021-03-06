class Api::V1::Invoices::SearchController < ApplicationController
  def show
    invoice = Invoice.find_by(request.query_parameters)
    render json: InvoiceSerializer.new(invoice)
  end

  def index
    invoices = Invoice.where(request.query_parameters).order(:id)
    render json: InvoiceSerializer.new(invoices)
  end
end
