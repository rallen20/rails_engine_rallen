class Customer < ApplicationRecord
  has_many :invoices

  def self.favorite_customer(merchant_id)
    joins(invoices: :transactions)
    .select("customers.*, count(transactions.id) as total_transactions")
    .where("transactions.result = 'success' AND invoices.merchant_id = #{merchant_id}")
    .group(:id)
    .order('total_transactions DESC')
    .limit(1)
  end
end
