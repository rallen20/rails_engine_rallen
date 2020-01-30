class Api::V1::Invoices::FindController < ApplicationController
  def show
    invoice = Invoice.find_by(request.query_parameters)
    render json: InvoiceSerializer.new(invoice)
  end
end
