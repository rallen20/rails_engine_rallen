require 'rails_helper'

describe "Merchants API" do
  it "sends a list of all merchants" do
    create_list(:merchant, 5)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body)
    expect(merchants["data"].count).to eq(5)
  end

  it "can get one merchant by it's id" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["data"]["id"]).to eq(id.to_s)
  end

  it "can get one merchant's list of items by merchant id" do
    id = create(:merchant).id
    create_list(:item, 3, merchant: Merchant.last)
    merchant_2 = create(:merchant)
    create_list(:item, 2, merchant: merchant_2)
    get "/api/v1/merchants/#{id}/items"

    expect(response).to be_successful

    merchant_items = JSON.parse(response.body)
    expect(merchant_items["data"].count).to eq(3)
  end

  it "can get one merchant's list of invoices by merchant id" do
    create(:customer)
    id = create(:merchant).id
    create_list(:invoice, 4, merchant: Merchant.last, customer: Customer.last)

    merchant_2 = create(:merchant)
    create_list(:invoice, 2, merchant: merchant_2, customer: Customer.last)
    get "/api/v1/merchants/#{id}/invoices"

    expect(response).to be_successful

    merchant_invoices = JSON.parse(response.body)
    expect(merchant_invoices["data"].count).to eq(4)
  end

  it "can return top x merchants ranked by total revenue" do
    merchant_1 = create(:merchant)
    merchant_1_items = create_list(:item, 4, merchant: merchant_1)
    merchant_1_invoices = create_list(:invoice, 4, merchant: merchant_1)
    merchant_1_invoices.each do |invoice|
      create(:transaction, invoice: invoice, result: 0)
    end
    create(:invoice_item, item: merchant_1_items[0], invoice: merchant_1_invoices[0], quantity: 1, unit_price: 10)
    create(:invoice_item, item: merchant_1_items[1], invoice: merchant_1_invoices[1], quantity: 1, unit_price: 50)
    create(:invoice_item, item: merchant_1_items[2], invoice: merchant_1_invoices[2], quantity: 1, unit_price: 50)
    create(:invoice_item, item: merchant_1_items[3], invoice: merchant_1_invoices[3], quantity: 1, unit_price: 50)

    merchant_2 = create(:merchant)
    merchant_2_items = create_list(:item, 4, merchant: merchant_2)
    merchant_2_invoices = create_list(:invoice, 4, merchant: merchant_2)
    merchant_2_invoices.each do |invoice|
      create(:transaction, invoice: invoice, result: 0)
    end
    create(:invoice_item, item: merchant_2_items[0], invoice: merchant_2_invoices[0], quantity: 1, unit_price: 50)
    create(:invoice_item, item: merchant_2_items[1], invoice: merchant_2_invoices[1], quantity: 1, unit_price: 50)
    create(:invoice_item, item: merchant_2_items[2], invoice: merchant_2_invoices[2], quantity: 1, unit_price: 50)
    create(:invoice_item, item: merchant_2_items[3], invoice: merchant_2_invoices[3], quantity: 1, unit_price: 50)


    merchant_3 = create(:merchant)
    merchant_3_items = create_list(:item, 4, merchant: merchant_3)
    merchant_3_invoices = create_list(:invoice, 4, merchant: merchant_3)
    merchant_3_invoices.each do |invoice|
      create(:transaction, invoice: invoice, result: 0)
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
end
