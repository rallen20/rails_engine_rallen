require 'csv'

desc "Import data from Sales Engine CSVs"
task :import => [:environment] do
  # Customer.destroy_all
  # Merchant.destroy_all
  # Item.destroy_all
  # Invoice.destroy_all
  # InvoiceItem.destroy_all
  # Transaction.destroy_all
  #
  CSV.foreach("lib/csvs/customers.csv", :headers => true) do |row|
    Customer.create!(row.to_hash)
  end
  CSV.foreach("lib/csvs/merchants.csv", :headers => true) do |row|
    Merchant.create!(row.to_hash)
  end
  CSV.foreach("lib/csvs/items.csv", :headers => true, header_converters: :symbol) do |row|
    Item.create!({
      id: row[:id],
      name: row[:name],
      description: row[:description],
      unit_price: row[:unit_price].to_f/100,
      merchant_id: row[:merchant_id],
      created_at: row[:created_at],
      updated_at: row[:updated_at]
    })
  end
  CSV.foreach("lib/csvs/invoices.csv", :headers => true) do |row|
    Invoice.create!(row.to_hash)
  end
  CSV.foreach("lib/csvs/invoice_items.csv", :headers => true, header_converters: :symbol) do |row|
    InvoiceItem.create!({
      id: row[:id],
      item_id: row[:item_id],
      invoice_id: row[:invoice_id],
      quantity: row[:quantity],
      unit_price: row[:unit_price].to_f/100,
      created_at: row[:created_at],
      updated_at: row[:updated_at]
    })
  end
  CSV.foreach("lib/csvs/transactions.csv", :headers => true) do |row|
    Transaction.create!(row.to_hash)
  end
end
