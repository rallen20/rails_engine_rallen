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
  xit "returns a single merchant by created at" do
    merchant = create(:merchant, created_at: "2012-03-27T14:54:05.000Z")

    get "/api/v1/merchants/find?updated_at=2012-03-27T14:54:05.000Z"
    expect(response).to be_successful
    merchant_parsed = JSON.parse(response.body)
    expect(merchant_parsed["data"]["id"]).to eq(merchant.id.to_s)
  end
  xit "returns a single merchant by updated at" do
  end
  it "returns all merchants by name" do
    merchant = create(:merchant, name: "Ryan Allen")
    get "/api/v1/merchants/find_all?name=#{merchant.name}"

    expect(response).to be_successful
  end
  # it "returns all merchants by name" do
  # end
  # it "returns all merchants by created_at" do
  # end
  # it "returns all merchants by updated_at" do
  # end
end
