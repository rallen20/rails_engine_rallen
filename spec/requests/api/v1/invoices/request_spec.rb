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
end
