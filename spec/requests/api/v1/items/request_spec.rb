require 'rails_helper'

describe "Items API" do
  it "sends a list of Items" do
    create_list(:item, 4)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body)["data"]

    expect(items.count).to eq(4)
  end

  it "can get one Item by id" do
    item = create(:item)

    get "/api/v1/items/#{item.id}"

    expect(response).to be_successful

    item_parsed = JSON.parse(response.body)
    expect(item_parsed["data"]["id"]).to eq(item.id.to_s)
  end

  it "returns a collection of associated invoice items" do
    item = create(:item)
    invoice_items = create_list(:invoice_item, 3, item: item)

    get "/api/v1/items/#{item.id}/invoice_items"

    expect(response).to be_successful

    invoice_items_parsed = JSON.parse(response.body)
    expect(invoice_items_parsed["data"].count).to eq(3)

  end

  it "returns the associated merchant" do
    item = create(:item)

    get "/api/v1/items/#{item.id}/merchant"

    expect(response).to be_successful

    merchant_parsed = JSON.parse(response.body)
    expect(merchant_parsed["data"]["id"]).to eq(item.merchant.id.to_s)
  end

  it "can return random" do
    create_list(:item, 3)
    get "/api/v1/items/random"
    expect(response).to be_successful
  end
end
