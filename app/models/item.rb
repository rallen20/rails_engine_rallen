class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.most_revenue_variable(item_count)
    joins(:invoice_items, invoices: :transactions)
    .select("items.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue")
    .where(transactions: {result: 'success'})
    .group(:id)
    .order('total_revenue DESC')
    .limit(item_count)
  end
end
