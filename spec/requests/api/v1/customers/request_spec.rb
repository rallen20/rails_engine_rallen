require 'rails_helper'

describe "Customers API" do
  it "sends a list of Customers" do
    create_list(:customer, 3)

    get '/api/v1/customers'

    expect(response).to be_successful

    customers = JSON.parse(response.body)["data"]

    expect(customers.count).to eq(3)
  end

  it "can get one Customers by id" do
    customer = create(:customer)

    get "/api/v1/customers/#{customer.id}"

    expect(response).to be_successful

    customer_parsed = JSON.parse(response.body)
    expect(customer_parsed["data"]["id"]).to eq(customer.id.to_s)
  end

  it "returns a collection of associated invoices" do
    customer = create(:customer)

    invoices = create_list(:invoice, 3, customer: customer)
    create_list(:invoice, 2)

    get "/api/v1/customers/#{customer.id}/invoices"

    expect(response).to be_successful

    invoices_parsed = JSON.parse(response.body)
    expect(invoices_parsed["data"].count).to eq(3)
  end

  it "returns a collection of associated transactions" do
    customer = create(:customer)
    invoice_1 = create(:invoice, customer: customer)
    invoice_2 = create(:invoice, customer: customer)
    invoice_3 = create(:invoice)

    create_list(:transaction, 2, invoice: invoice_3)

    create_list(:transaction, 3, invoice: invoice_1)
    create(:transaction, invoice: invoice_2)

    get "/api/v1/customers/#{customer.id}/transactions"

    expect(response).to be_successful

    transactions_parsed = JSON.parse(response.body)
    expect(transactions_parsed["data"].count).to eq(4)
  end
end
