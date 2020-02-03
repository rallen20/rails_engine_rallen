require 'rails_helper'

describe "Merchants API - Find" do
  it "returns a single merchant by id" do
    merchant = create(:merchant)

    get "/api/v1/merchants/find?id=#{merchant.id}"

    expect(response).to be_successful
    merchant_parsed = JSON.parse(response.body)
    expect(merchant_parsed["data"]["id"]).to eq(merchant.id.to_s)
  end
  it "returns a single merchant by name" do
    merchant = create(:merchant)

    get "/api/v1/merchants/find?name=#{merchant.name}"
    expect(response).to be_successful
    merchant_parsed = JSON.parse(response.body)
    expect(merchant_parsed["data"]["id"]).to eq(merchant.id.to_s)
  end
  it "returns a single merchant by created at" do
    merchant = create(:merchant, created_at: "2010-01-01 00:00:00 UTC")

    get "/api/v1/merchants/find?created_at=2010-01-01"

    expect(response).to be_successful

    merchant_parsed = JSON.parse(response.body)
    expect(merchant_parsed["data"]["id"]).to eq(merchant.id.to_s)
  end
  it "returns a single merchant by updated at" do
    merchant = create(:merchant, updated_at: "2010-01-01 00:00:00 UTC")

    get "/api/v1/merchants/find?updated_at=2010-01-01"

    expect(response).to be_successful

    merchant_parsed = JSON.parse(response.body)
    expect(merchant_parsed["data"]["id"]).to eq(merchant.id.to_s)
  end
  it "returns all merchants by name" do
    merchant = create(:merchant, name: "Ryan Allen")
    get "/api/v1/merchants/find_all?name=#{merchant.name}"

    expect(response).to be_successful
  end
  it "returns all merchants by created_at" do
    create_list(:merchant, 3, created_at: "2010-01-01 00:00:00 UTC")

    get "/api/v1/merchants/find_all?created_at=2010-01-01"

    expect(response).to be_successful

    merchant_parsed = JSON.parse(response.body)
    expect(merchant_parsed["data"].count).to eq(3)
  end
  it "returns all merchants by updated_at" do
    create_list(:merchant, 3, updated_at: "2011-01-01 00:00:00 UTC")

    get "/api/v1/merchants/find_all?updated_at=2011-01-01"

    expect(response).to be_successful

    merchant_parsed = JSON.parse(response.body)
    expect(merchant_parsed["data"].count).to eq(3)
  end
end
