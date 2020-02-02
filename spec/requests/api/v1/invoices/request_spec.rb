require 'rails_helper'

describe "Invoices API" do
  it "sends a list of invoices" do
    create_list(:invoice, 3)

    get '/api/v1/invoices'

    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices["data"].count).to eq(3)
  end

  it "can get one invoice by id" do
    invoice = create(:invoice)

    get "/api/v1/invoices/#{invoice.id}"

    expect(response).to be_successful

    invoice_parsed = JSON.parse(response.body)
    expect(invoice_parsed["data"]["id"]).to eq(invoice.id.to_s)
  end

  it "returns a collection of associated transactions by invoice id" do
    invoice = create(:invoice)
    transactions = create_list(:transaction, 3, invoice: invoice)
    create_list(:transaction, 2)

    get "/api/v1/invoices/#{invoice.id}/transactions"

    expect(response).to be_successful

    transactions = JSON.parse(response.body)
    expect(transactions["data"].count).to eq(3)
  end

  it "returns a collection of associated items by invoice id" do
    invoice = create(:invoice)
    invoice_items = create_list(:invoice_item, 4, invoice: invoice)
    create(:invoice_item)

    get "/api/v1/invoices/#{invoice.id}/items"

    expect(response).to be_successful

    items = JSON.parse(response.body)
    expect(items["data"].count).to eq(4)
  end

  it "returns a collection of associated invoice_items by invoice id" do
    invoice = create(:invoice)
    invoice_items = create_list(:invoice_item, 3, invoice: invoice)
    create(:invoice_item)

    get "/api/v1/invoices/#{invoice.id}/invoice_items"

    expect(response).to be_successful

    items = JSON.parse(response.body)
    expect(items["data"].count).to eq(3)
  end

  it "returns the associated customer by invoice id" do
    invoice = create(:invoice)

    get "/api/v1/invoices/#{invoice.id}/customer"

    expect(response).to be_successful

    customer = JSON.parse(response.body)
    expect(customer["data"]["id"]).to eq(invoice.customer.id.to_s)
  end

  it "returns the associated merchant by invoice id" do
    invoice = create(:invoice)

    get "/api/v1/invoices/#{invoice.id}/merchant"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)
    expect(merchant["data"]["id"]).to eq(invoice.merchant.id.to_s)
  end

  it "can return random" do
    create_list(:invoice, 3)
    get "/api/v1/invoices/random"
    expect(response).to be_successful
  end
end
