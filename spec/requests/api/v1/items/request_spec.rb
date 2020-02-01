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
end
