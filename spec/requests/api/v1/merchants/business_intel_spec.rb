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

    xit "returns the total revenue for date x across all merchants for a specific date" do
      merchant_1 = create(:merchant)
      merchant_1_items = create_list(:item, 4, merchant: merchant_1)
      merchant_1_invoices = create_list(:invoice, 4, merchant: merchant_1)
      merchant_1_invoices.each do |invoice|
        create(:transaction, invoice: invoice, result: 'success', created_at: Time.parse("2010-10-31"))
      end
      create(:invoice_item, item: merchant_1_items[0], invoice: merchant_1_invoices[0], quantity: 1, unit_price: 10)
      create(:invoice_item, item: merchant_1_items[1], invoice: merchant_1_invoices[1], quantity: 1, unit_price: 50)
      create(:invoice_item, item: merchant_1_items[2], invoice: merchant_1_invoices[2], quantity: 1, unit_price: 50)
      create(:invoice_item, item: merchant_1_items[3], invoice: merchant_1_invoices[3], quantity: 1, unit_price: 50)

      merchant_2 = create(:merchant)
      merchant_2_items = create_list(:item, 4, merchant: merchant_2)
      merchant_2_invoices = create_list(:invoice, 4, merchant: merchant_2)
      merchant_2_invoices.each do |invoice|
        create(:transaction, invoice: invoice, result: 'success', created_at: Time.parse("2010-10-31"))
      end
      create(:invoice_item, item: merchant_2_items[0], invoice: merchant_2_invoices[0], quantity: 1, unit_price: 50)
      create(:invoice_item, item: merchant_2_items[1], invoice: merchant_2_invoices[1], quantity: 1, unit_price: 50)
      create(:invoice_item, item: merchant_2_items[2], invoice: merchant_2_invoices[2], quantity: 1, unit_price: 50)
      create(:invoice_item, item: merchant_2_items[3], invoice: merchant_2_invoices[3], quantity: 1, unit_price: 50)


      merchant_3 = create(:merchant)
      merchant_3_items = create_list(:item, 4, merchant: merchant_3)
      merchant_3_invoices = create_list(:invoice, 4, merchant: merchant_3)
      merchant_3_invoices.each do |invoice|
        create(:transaction, invoice: invoice, result: 'success', created_at: Time.parse("2010-10-25"))
      end
      create(:invoice_item, item: merchant_3_items[0], invoice: merchant_3_invoices[0], quantity: 1, unit_price: 50)
      create(:invoice_item, item: merchant_3_items[1], invoice: merchant_3_invoices[1], quantity: 1, unit_price: 10)
      # fake date not searching for
      create(:invoice_item, item: merchant_3_items[2], invoice: merchant_3_invoices[2], quantity: 1, unit_price: 10)
      create(:invoice_item, item: merchant_3_items[3], invoice: merchant_3_invoices[3], quantity: 1, unit_price: 50)

      merchant_4 = create(:merchant)

      get "/api/v1/merchants/revenue?date=2010-10-31"

      expect(response).to be_successful

      revenue = JSON.parse(response.body)
      expect(revenue["data"]["attributes"]["total_revenue"]).to eq(200)
    end

    it "returns the favorite customer associated with one merchant" do
      customer_1 = create(:customer)
      customer_2 = create(:customer)
      customer_3 = create(:customer)

      merchant = create(:merchant)
      item_1 = create(:item, merchant: merchant)
      item_2 = create(:item, merchant: merchant)
      item_3 = create(:item, merchant: merchant)

      invoice_1 = create(:invoice, customer: customer_1, merchant: merchant)
      invoice_2 = create(:invoice, customer: customer_2, merchant: merchant)
      invoice_3 = create(:invoice, customer: customer_3, merchant: merchant)

      create(:transaction, result: 'success', invoice: invoice_1)
      create_list(:transaction, 3, result: 'success', invoice: invoice_2)
      create_list(:transaction, 2, result: 'success', invoice: invoice_3)
      create_list(:transaction, 2, result: 'failed', invoice: invoice_3)

      get "/api/v1/merchants/#{merchant.id}/favorite_customer"

      expect(response).to be_successful
      favorite_customer = JSON.parse(response.body)["data"]
      expect(favorite_customer["attributes"]["id"]).to eq(customer_2.id)
    end
end
