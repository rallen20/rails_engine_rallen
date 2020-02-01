require 'rails_helper'

describe "Transactions API - Search" do
  it "returns a single transaction by id" do
    transaction = create(:transaction)

    get "/api/v1/transactions/find?id=#{transaction.id}"

    expect(response).to be_successful

    transaction_parsed = JSON.parse(response.body)
    expect(transaction_parsed["data"]["id"]).to eq(transaction.id.to_s)
  end

  it "returns a single transaction by invoice_id" do
    transaction = create(:transaction)

    get "/api/v1/transactions/find?invoice_id=#{transaction.invoice_id}"

    expect(response).to be_successful

    transaction_parsed = JSON.parse(response.body)
    expect(transaction_parsed["data"]["id"]).to eq(transaction.id.to_s)
  end

  it "returns a single transaction by credit_card_number" do
    transaction = create(:transaction)

    get "/api/v1/transactions/find?credit_card_number=#{transaction.credit_card_number}"

    expect(response).to be_successful

    transaction_parsed = JSON.parse(response.body)
    expect(transaction_parsed["data"]["id"]).to eq(transaction.id.to_s)
  end

  it "returns a single transaction by credit_card_expiration_date" do
    transaction = create(:transaction)

    get "/api/v1/transactions/find?credit_card_expiration_date=#{transaction.credit_card_expiration_date}"

    expect(response).to be_successful

    transaction_parsed = JSON.parse(response.body)
    expect(transaction_parsed["data"]["id"]).to eq(transaction.id.to_s)
  end

  it "returns a single transaction by result" do
    transaction = create(:transaction)

    get "/api/v1/transactions/find?result=#{transaction.result}"

    expect(response).to be_successful

    transaction_parsed = JSON.parse(response.body)
    expect(transaction_parsed["data"]["id"]).to eq(transaction.id.to_s)
  end

  xit "returns a single transaction by created_at" do
  end

  xit "returns a single transaction by updated_at" do
  end

  # find_all
  it "returns all transactions by id" do
    transaction = create(:transaction)
    create_list(:transaction, 2)

    get "/api/v1/transactions/find_all?id=#{transaction.id}"

    expect(response).to be_successful

    transaction_parsed = JSON.parse(response.body)
    expect(transaction_parsed["data"].count).to eq(1)
  end

  it "returns all transactions by invoice_id" do
    invoice = create(:invoice)
    transactions = create_list(:transaction, 2, invoice: invoice)
    create_list(:transaction, 3)

    get "/api/v1/transactions/find_all?invoice_id=#{transactions.first.invoice_id}"

    expect(response).to be_successful

    transaction_parsed = JSON.parse(response.body)
    expect(transaction_parsed["data"].count).to eq(2)
  end

  it "returns all transactions by credit_card_number" do
    transactions = create_list(:transaction, 4, credit_card_number: 4654405418249632)
    create(:transaction)

    get "/api/v1/transactions/find_all?credit_card_number=#{transactions.first.credit_card_number}"

    expect(response).to be_successful

    transaction_parsed = JSON.parse(response.body)
    expect(transaction_parsed["data"].count).to eq(4)
  end

  it "returns all transactions by credit_card_expiration_date" do
    transactions = create_list(:transaction, 2, credit_card_expiration_date: 1)
    create(:transaction)

    get "/api/v1/transactions/find_all?credit_card_expiration_date=#{transactions.first.credit_card_expiration_date}"

    expect(response).to be_successful

    transaction_parsed = JSON.parse(response.body)
    expect(transaction_parsed["data"].count).to eq(2)
  end

  it "returns all transactions by result" do
    transactions = create_list(:transaction, 2, result: 'failed')
    create_list(:transaction, 3, result: 'success')

    get "/api/v1/transactions/find_all?result=#{transactions.first.result}"

    expect(response).to be_successful

    transaction_parsed = JSON.parse(response.body)
    expect(transaction_parsed["data"].count).to eq(2)
  end

  xit "returns all transactions by created_at" do
  end

  xit "returns all transactions by updated_at" do
  end
end
