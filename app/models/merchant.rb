class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items

  def self.most_revenue_variable(merchant_count)
    joins(invoices: [:invoice_items, :transactions])
    .select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue")
    .group(:id)
    .merge(Transaction.successful)
    .order('total_revenue DESC')
    .limit(merchant_count)
  end

  def self.favorite_merchant(customer_id)
    joins(invoices: :transactions)
    .select("merchants.*, count(transactions.id) as total_transactions")
    .merge(Transaction.successful)
    .where(invoices: {customer_id: customer_id})
    .group(:id)
    .order('total_transactions DESC')
    .limit(1)
  end
end
