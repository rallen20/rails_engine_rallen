class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.most_revenue_variable(item_count)
    joins(:invoice_items, invoices: :transactions)
    .select("items.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue")
    .merge(Transaction.successful)
    .group(:id)
    .order('total_revenue DESC')
    .limit(item_count)
  end

  def best_day
    # only 1 or the other tests for this in spec harness will pass
    # this is an ISSUE
    invoices
    .joins(:transactions)
    .select("invoices.created_at, SUM(invoice_items.quantity) AS total_quantity")
    .merge(Transaction.successful)
    .group("invoices.created_at")
    .order("total_quantity DESC, invoices.created_at DESC")
    .first
    .created_at
    .strftime("%Y-%m-%d")
  end
end
