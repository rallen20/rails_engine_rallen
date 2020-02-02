require 'rails_helper'

describe "Transactions API" do
  it "sends a list of Transactions" do
    create_list(:transaction, 3)

    get '/api/v1/transactions'

    expect(response).to be_successful

    transactions = JSON.parse(response.body)["data"]

    expect(transactions.count).to eq(3)
  end

  it "can get one Transaction by id" do
    transaction = create(:transaction)

    get "/api/v1/transactions/#{transaction.id}"

    expect(response).to be_successful

    transaction_parsed = JSON.parse(response.body)
    expect(transaction_parsed["data"]["id"]).to eq(transaction.id.to_s)
  end

  it "returns the associated invoice" do
    transaction = create(:transaction)

    get "/api/v1/transactions/#{transaction.id}/invoice"

    expect(response).to be_successful

    invoice_parsed = JSON.parse(response.body)
    expect(invoice_parsed["data"]["id"]).to eq(transaction.invoice.id.to_s)
  end

  it "can return random" do
    create_list(:transaction, 3)
    get "/api/v1/transactions/random"
    expect(response).to be_successful
  end
end
