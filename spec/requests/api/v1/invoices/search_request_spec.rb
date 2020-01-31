require 'rails_helper'

describe "Invoice API - Search" do
  it "returns a single invoice by id" do
    invoice = create(:invoice)

    get "/api/v1/invoices/find?id=#{invoice.id}"

    expect(response).to be_successful

    invoice_parsed = JSON.parse(response.body)
    expect(invoice_parsed["data"]["id"]).to eq(invoice.id.to_s)
  end
  it "returns a single invoice by customer_id" do
    invoice = create(:invoice)

    get "/api/v1/invoices/find?customer_id=#{invoice.customer.id}"

    expect(response).to be_successful

    invoice_parsed = JSON.parse(response.body)
    expect(invoice_parsed["data"]["id"]).to eq(invoice.id.to_s)
  end
  it "returns a single invoice by merchant_id" do
    invoice = create(:invoice)

    get "/api/v1/invoices/find?merchant_id=#{invoice.merchant_id}"

    expect(response).to be_successful

    invoice_parsed = JSON.parse(response.body)
    expect(invoice_parsed["data"]["id"]).to eq(invoice.id.to_s)
  end
  it "returns a single invoice by status" do
    invoice = create(:invoice)

    get "/api/v1/invoices/find?status=#{invoice.status}"

    expect(response).to be_successful

    invoice_parsed = JSON.parse(response.body)
    expect(invoice_parsed["data"]["id"]).to eq(invoice.id.to_s)
  end
  xit "returns a single invoice by created_at" do
  end
  xit "returns a single invoice by updated_at" do
  end
  it "returns all invoices by id" do
    invoice = create(:invoice)
    invoice_2 = create(:invoice)
    get "/api/v1/invoices/find_all?id=#{invoice.id}"

    expect(response).to be_successful

    invoices_parsed = JSON.parse(response.body)
    expect(invoices_parsed["data"].count).to eq(1)
  end
  it "returns all invoices by customer_id" do
    customer = create(:customer)
    invoices = create_list(:invoice, 2, customer: customer)
    invoice_2 = create(:invoice)

    get "/api/v1/invoices/find_all?customer_id=#{customer.id}"

    expect(response).to be_successful

    invoices_parsed = JSON.parse(response.body)
    expect(invoices_parsed["data"].count).to eq(2)
  end
  it "returns all invoices by merchant_id" do
    merchant = create(:merchant)
    invoices = create_list(:invoice, 4, merchant: merchant)
    invoice_2 = create(:invoice)

    get "/api/v1/invoices/find_all?merchant_id=#{merchant.id}"

    expect(response).to be_successful

    invoices_parsed = JSON.parse(response.body)
    expect(invoices_parsed["data"].count).to eq(4)
  end
  it "returns all invoices by status" do
    invoices = create_list(:invoice, 2)

    get "/api/v1/invoices/find_all?status=#{invoices.first.status}"

    expect(response).to be_successful
    invoices_parsed = JSON.parse(response.body)
    expect(invoices_parsed["data"].count).to eq(2)
  end
  xit "returns all invoices by created_at" do
  end
  xit "returns all invoices by updated_at" do
  end
end
