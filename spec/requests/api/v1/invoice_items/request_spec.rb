require 'rails_helper'

describe "Invoice Items API" do
  it "sends a list of Invoice Items" do
    create_list(:invoice_item, 6)

    get '/api/v1/invoice_items'

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)["data"]

    expect(invoice_items.count).to eq(6)
  end

  it "can get one Invoice Item by id" do
    invoice_item = create(:invoice_item)

    get "/api/v1/invoice_items/#{invoice_item.id}"

    expect(response).to be_successful

    invoice_items_parsed = JSON.parse(response.body)
    expect(invoice_items_parsed["data"]["id"]).to eq(invoice_item.id.to_s)
  end

  it "returns the associated item by invoice item id" do
    invoice_item = create(:invoice_item)

    get "/api/v1/invoice_items/#{invoice_item.id}/item"

    expect(response).to be_successful

    item = JSON.parse(response.body)
    expect(item["data"]["id"]).to eq(invoice_item.item.id.to_s)
  end

  it "returns the associated invoice by invoice item id" do
    invoice_item = create(:invoice_item)

    get "/api/v1/invoice_items/#{invoice_item.id}/invoice"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)
    expect(invoice["data"]["id"]).to eq(invoice_item.invoice.id.to_s)
  end

  it "can return random" do
    create_list(:invoice_item, 3)
    get "/api/v1/invoice_items/random"
    expect(response).to be_successful
  end
end
