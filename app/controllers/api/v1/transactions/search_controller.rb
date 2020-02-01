class Api::V1::Transactions::SearchController < ApplicationController
  def show
    transaction = Transaction.find_by(request.query_parameters)
    render json: TransactionSerializer.new(transaction)
  end

  def index
    transactions = Transaction.where(request.query_parameters).order(:id)
    render json: TransactionSerializer.new(transactions)
  end
end
