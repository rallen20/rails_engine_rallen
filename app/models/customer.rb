class Customer < ApplicationRecord
  has_many :invoices

  def self.favorite_customer(merchant_id)
    joins(invoices: :transactions)
    .merge(Transaction.successful)
    .select("customers.*, count(transactions.id) as total_transactions")
    .where(invoices: {merchant_id: merchant_id})
    .group(:id)
    .order('total_transactions DESC')
    .limit(1)
  end
end
