require 'rails_helper'

describe "Customers API - Business Intel" do
  it "returns a merchant where the customer has conducted the most successful transactions" do
    customer = create(:customer)
    merchant_1 = create(:merchant)
    merchant_1_invoice_1 = create(:invoice, customer: customer, merchant: merchant_1)
    create(:transaction, invoice: merchant_1_invoice_1, result: 'success')
    merchant_1_invoice_2 = create(:invoice, customer: customer, merchant: merchant_1)
    create(:transaction, invoice: merchant_1_invoice_2, result: 'failure')

    merchant_2 = create(:merchant)
    merchant_2_invoice_1 = create(:invoice, customer: customer, merchant: merchant_2)
    create(:transaction, invoice: merchant_2_invoice_1, result: 'success')
    merchant_2_invoice_2 = create(:invoice, customer: customer, merchant: merchant_2)
    create(:transaction, invoice: merchant_2_invoice_1, result: 'success')

    get "/api/v1/customers/#{customer.id}/favorite_merchant"

    expect(response).to be_successful

    favorite_merchant = JSON.parse(response.body)

    expect(favorite_merchant["data"]["attributes"]["id"]).to eq(merchant_2.id)
  end
end
