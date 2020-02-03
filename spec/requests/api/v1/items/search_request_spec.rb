require 'rails_helper'

describe "Items API - Search" do
  it "returns a single item by id" do
    item = create(:item)

    get "/api/v1/items/find?id=#{item.id}"

    expect(response).to be_successful

    item_parsed = JSON.parse(response.body)
    expect(item_parsed["data"]["id"]).to eq(item.id.to_s)
  end

  it "returns a single item by name" do
    item = create(:item)

    get "/api/v1/items/find?name=#{item.name}"

    expect(response).to be_successful

    item_parsed = JSON.parse(response.body)
    expect(item_parsed["data"]["id"]).to eq(item.id.to_s)
  end

  it "returns a single item by description" do
    item = create(:item)

    get "/api/v1/items/find?description=#{item.description}"

    expect(response).to be_successful

    item_parsed = JSON.parse(response.body)
    expect(item_parsed["data"]["id"]).to eq(item.id.to_s)
  end

  it "returns a single item by unit_price" do
    item = create(:item)

    get "/api/v1/items/find?unit_price=#{item.unit_price}"

    expect(response).to be_successful

    item_parsed = JSON.parse(response.body)
    expect(item_parsed["data"]["id"]).to eq(item.id.to_s)
  end

  it "returns a single item by merchant_id" do
    item = create(:item)

    get "/api/v1/items/find?merchant_id=#{item.merchant_id}"

    expect(response).to be_successful

    item_parsed = JSON.parse(response.body)
    expect(item_parsed["data"]["id"]).to eq(item.id.to_s)
  end

  it "returns a single item by created_at" do
    item = create(:item, created_at: "2010-01-01 00:00:00 UTC")

    get "/api/v1/items/find?created_at=2010-01-01"

    expect(response).to be_successful

    item_parsed = JSON.parse(response.body)
    expect(item_parsed["data"]["id"]).to eq(item.id.to_s)
  end
  it "returns a single item by updated_at" do
    item = create(:item, updated_at: "2010-01-01 00:00:00 UTC")

    get "/api/v1/items/find?updated_at=2010-01-01"

    expect(response).to be_successful

    item_parsed = JSON.parse(response.body)
    expect(item_parsed["data"]["id"]).to eq(item.id.to_s)
  end

  # find all
  it "returns all items by id" do
    item = create(:item)
    create_list(:item, 2)

    get "/api/v1/items/find_all?id=#{item.id}"

    expect(response).to be_successful

    item_parsed = JSON.parse(response.body)
    expect(item_parsed["data"].count).to eq(1)
  end

  it "returns all items by name" do
    items = create_list(:item, 3, name: 'ryan')
    create_list(:item, 2)

    get "/api/v1/items/find_all?name=#{items.first.name}"

    expect(response).to be_successful

    item_parsed = JSON.parse(response.body)
    expect(item_parsed["data"].count).to eq(3)
  end

  it "returns all items by description" do
    items = create_list(:item, 2, description: 'this is a good')
    create_list(:item, 3)

    get "/api/v1/items/find_all?description=#{items.first.description}"

    expect(response).to be_successful

    item_parsed = JSON.parse(response.body)
    expect(item_parsed["data"].count).to eq(2)
  end

  it "returns all items by unit_price" do
    items = create_list(:item, 3, unit_price: 100)
    create_list(:item, 2, unit_price: 200)

    get "/api/v1/items/find_all?unit_price=#{items.first.unit_price}"

    expect(response).to be_successful

    item_parsed = JSON.parse(response.body)
    expect(item_parsed["data"].count).to eq(3)
  end

  it "returns all items by merchant_id" do
    merchant = create(:merchant)
    items = create_list(:item, 4, merchant: merchant)
    create_list(:item, 2)

    get "/api/v1/items/find_all?merchant_id=#{items.first.merchant_id}"

    expect(response).to be_successful

    item_parsed = JSON.parse(response.body)
    expect(item_parsed["data"].count).to eq(4)
  end

  it "returns all items by created_at" do
    create_list(:item, 2, created_at: "2010-01-01 00:00:00 UTC")

    get "/api/v1/items/find_all?created_at=2010-01-01"

    expect(response).to be_successful

    item_parsed = JSON.parse(response.body)
    expect(item_parsed["data"].count).to eq(2)
  end
  it "returns all items by updated_at" do
    create_list(:item, 3, updated_at: "2010-01-05 00:00:00 UTC")

    get "/api/v1/items/find_all?updated_at=2010-01-05"

    expect(response).to be_successful

    item_parsed = JSON.parse(response.body)
    expect(item_parsed["data"].count).to eq(3)
  end
end
