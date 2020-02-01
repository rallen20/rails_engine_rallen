class Transaction < ApplicationRecord
  belongs_to :invoice

  def self.all_customers_transactions(customer_id)
    joins(:invoice).where("invoices.customer_id = #{customer_id}")
  end
end
