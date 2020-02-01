class Api::V1::Customers::TransactionsController < ApplicationController
  def index
    transactions = Transaction.all_customers_transactions(params[:customer_id])
    render json: TransactionSerializer.new(transactions)
  end
end
