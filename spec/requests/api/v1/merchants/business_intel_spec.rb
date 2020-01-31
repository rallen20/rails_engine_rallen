require 'rails_helper'

describe "Merchants API - Business Intel" do
    it "can return top x merchants ranked by total revenue" do
      merchant_1 = create(:merchant)
      merchant_1_items = create_list(:item, 4, merchant: merchant_1)
      merchant_1_invoices = create_list(:invoice, 4, merchant: merchant_1)
      merchant_1_invoices.each do |invoice|
        create(:transaction, invoice: invoice, result: 'success')
      end
      create(:invoice_item, item: merchant_1_items[0], invoice: merchant_1_invoices[0], quantity: 1, unit_price: 10)
      create(:invoice_item, item: merchant_1_items[1], invoice: merchant_1_invoices[1], quantity: 1, unit_price: 50)
      create(:invoice_item, item: merchant_1_items[2], invoice: merchant_1_invoices[2], quantity: 1, unit_price: 50)
      create(:invoice_item, item: merchant_1_items[3], invoice: merchant_1_invoices[3], quantity: 1, unit_price: 50)

      merchant_2 = create(:merchant)
      merchant_2_items = create_list(:item, 4, merchant: merchant_2)
      merchant_2_invoices = create_list(:invoice, 4, merchant: merchant_2)
      merchant_2_invoices.each do |invoice|
        create(:transaction, invoice: invoice, result: 'success')
      end
      create(:invoice_item, item: merchant_2_items[0], invoice: merchant_2_invoices[0], quantity: 1, unit_price: 50)
      create(:invoice_item, item: merchant_2_items[1], invoice: merchant_2_invoices[1], quantity: 1, unit_price: 50)
      create(:invoice_item, item: merchant_2_items[2], invoice: merchant_2_invoices[2], quantity: 1, unit_price: 50)
      create(:invoice_item, item: merchant_2_items[3], invoice: merchant_2_invoices[3], quantity: 1, unit_price: 50)


      merchant_3 = create(:merchant)
      merchant_3_items = create_list(:item, 4, merchant: merchant_3)
      merchant_3_invoices = create_list(:invoice, 4, merchant: merchant_3)
      merchant_3_invoices.each do |invoice|
        create(:transaction, invoice: invoice, result: 'success')
      end
      create(:invoice_item, item: merchant_3_items[0], invoice: merchant_3_invoices[0], quantity: 1, unit_price: 50)
      create(:invoice_item, item: merchant_3_items[1], invoice: merchant_3_invoices[1], quantity: 1, unit_price: 10)
      create(:invoice_item, item: merchant_3_items[2], invoice: merchant_3_invoices[2], quantity: 1, unit_price: 10)
      create(:invoice_item, item: merchant_3_items[3], invoice: merchant_3_invoices[3], quantity: 1, unit_price: 50)

      merchant_4 = create(:merchant)

      get "/api/v1/merchants/most_revenue?quantity=3"

      expect(response).to be_successful

      top_merchants = JSON.parse(response.body)
      expect(top_merchants["data"].count).to eq(3)
      expect(top_merchants["data"].first["id"]).to eq(merchant_2.id.to_s)
    end

    it "returns the total revenue for date x across all merchants for a specific date" do
      merchant_1 = create(:merchant)
      merchant_1_items = create_list(:item, 4, merchant: merchant_1)
      merchant_1_invoices = create_list(:invoice, 4, merchant: merchant_1)
      merchant_1_invoices.each do |invoice|
        create(:transaction, invoice: invoice, result: 'success')
      end
      create(:invoice_item, item: merchant_1_items[0], invoice: merchant_1_invoices[0], quantity: 1, unit_price: 10, created_at: Time.parse("2010-10-31"))
      create(:invoice_item, item: merchant_1_items[1], invoice: merchant_1_invoices[1], quantity: 1, unit_price: 50, created_at: Time.parse("2010-10-31"))
      create(:invoice_item, item: merchant_1_items[2], invoice: merchant_1_invoices[2], quantity: 1, unit_price: 50, created_at: Time.parse("2010-10-31"))
      create(:invoice_item, item: merchant_1_items[3], invoice: merchant_1_invoices[3], quantity: 1, unit_price: 50, created_at: Time.new)

      merchant_2 = create(:merchant)
      merchant_2_items = create_list(:item, 4, merchant: merchant_2)
      merchant_2_invoices = create_list(:invoice, 4, merchant: merchant_2)
      merchant_2_invoices.each do |invoice|
        create(:transaction, invoice: invoice, result: 'success')
      end
      create(:invoice_item, item: merchant_2_items[0], invoice: merchant_2_invoices[0], quantity: 1, unit_price: 50, created_at: Time.parse("2010-10-31"))
      create(:invoice_item, item: merchant_2_items[1], invoice: merchant_2_invoices[1], quantity: 1, unit_price: 50, created_at: Time.new)
      create(:invoice_item, item: merchant_2_items[2], invoice: merchant_2_invoices[2], quantity: 1, unit_price: 50, created_at: Time.new)
      create(:invoice_item, item: merchant_2_items[3], invoice: merchant_2_invoices[3], quantity: 1, unit_price: 50, created_at: Time.new)


      merchant_3 = create(:merchant)
      merchant_3_items = create_list(:item, 4, merchant: merchant_3)
      merchant_3_invoices = create_list(:invoice, 4, merchant: merchant_3)
      merchant_3_invoices.each do |invoice|
        create(:transaction, invoice: invoice, result: 'success')
      end
      create(:invoice_item, item: merchant_3_items[0], invoice: merchant_3_invoices[0], quantity: 1, unit_price: 50, created_at: Time.parse("2010-10-31"))
      create(:invoice_item, item: merchant_3_items[1], invoice: merchant_3_invoices[1], quantity: 1, unit_price: 10, created_at: Time.parse("2010-10-31"))
      # fake date not searching for
      create(:invoice_item, item: merchant_3_items[2], invoice: merchant_3_invoices[2], quantity: 1, unit_price: 10, created_at: Time.parse("2010-10-01"))
      create(:invoice_item, item: merchant_3_items[3], invoice: merchant_3_invoices[3], quantity: 1, unit_price: 50, created_at: Time.parse("2011-10-31"))

      merchant_4 = create(:merchant)

      get "/api/v1/merchants/revenue?date=2010-10-31"

    end
end
