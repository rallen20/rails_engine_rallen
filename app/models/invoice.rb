class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant

  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  def self.total_revenue_on_specific_date(requested_date)
    where(:created_at => Time.zone.parse(requested_date)..Time.zone.parse(requested_date).next_day)
    .joins(:invoice_items, :transactions)
    .where("transactions.result = 'success'")
    .sum('invoice_items.quantity * invoice_items.unit_price')
  end
end
