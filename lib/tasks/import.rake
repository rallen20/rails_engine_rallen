require 'csv'

desc "Import data from Sales Engine CSVs"
task :import => [:environment] do
  CSV.foreach("lib/csvs/customers.csv", :headers => true) do |row|
    Customer.create!(row.to_hash)
  end
  CSV.foreach("lib/csvs/merchants.csv", :headers => true) do |row|
    Merchant.create!(row.to_hash)
  end
  CSV.foreach("lib/csvs/items.csv", :headers => true) do |row|
    Item.create!(row.to_hash)
  end
  CSV.foreach("lib/csvs/invoices.csv", :headers => true) do |row|
    Invoice.create!(row.to_hash)
  end
  CSV.foreach("lib/csvs/invoice_items.csv", :headers => true) do |row|
    InvoiceItem.create!(row.to_hash)
  end
  CSV.foreach("lib/csvs/transactions.csv", :headers => true) do |row|
    Transaction.create!(row.to_hash)
  end
end
