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
    create(:merchant)
    create_list(:item, 2, merchant: Merchant.last)
    get "/api/v1/merchants/#{id}/items"

    merchant_items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant_items["data"].count).to eq(3)
  end

  it "can get one merchant's list of invoices by merchant id" do

  end
end
