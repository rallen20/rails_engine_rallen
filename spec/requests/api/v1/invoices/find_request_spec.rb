require 'rails_helper'

describe "Invoice API - Find" do
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
end
