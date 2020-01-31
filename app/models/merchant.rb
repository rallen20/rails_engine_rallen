class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items

  def self.most_revenue_variable(merchant_count)
    joins(invoices: [:invoice_items, :transactions])
    .select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue")
    .group(:id)
    .where(transactions: {result: 'success'})
    .order('total_revenue DESC')
    .limit(merchant_count)
  end
end
