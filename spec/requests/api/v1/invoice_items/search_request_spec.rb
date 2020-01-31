require 'rails_helper'

describe "Invoice Items API - Search" do
  it "returns a single invoice item by id" do
    invoice_item = create(:invoice_item)
    invoice_item_2 = create(:invoice_item)

    get "/api/v1/invoice_items/find?id=#{invoice_item.id}"

    expect(response).to be_successful

    invoice_item_parsed = JSON.parse(response.body)["data"]
    expect(invoice_item_parsed["attributes"]["id"]).to eq(invoice_item.id)
  end

  it "returns a single invoice item by item_id" do
    invoice_item = create(:invoice_item)
    invoice_item_2 = create(:invoice_item)

    get "/api/v1/invoice_items/find?item_id=#{invoice_item.item_id}"

    expect(response).to be_successful

    invoice_item_parsed = JSON.parse(response.body)["data"]
    expect(invoice_item_parsed["attributes"]["id"]).to eq(invoice_item.id)
  end

  it "returns a single invoice item by invoice_id" do
    invoice_item = create(:invoice_item)
    invoice_item_2 = create(:invoice_item)

    get "/api/v1/invoice_items/find?invoice_id=#{invoice_item.invoice_id}"

    expect(response).to be_successful

    invoice_item_parsed = JSON.parse(response.body)["data"]
    expect(invoice_item_parsed["attributes"]["id"]).to eq(invoice_item.id)
  end

  it "returns a single invoice item by quantity" do
    invoice_item = create(:invoice_item)
    invoice_item_2 = create(:invoice_item)

    get "/api/v1/invoice_items/find?quantity=#{invoice_item.quantity}"

    expect(response).to be_successful

    invoice_item_parsed = JSON.parse(response.body)["data"]
    expect(invoice_item_parsed["attributes"]["id"]).to eq(invoice_item.id)
  end

  it "returns a single invoice item by unit_price" do
    invoice_item = create(:invoice_item)
    invoice_item_2 = create(:invoice_item)

    get "/api/v1/invoice_items/find?id=#{invoice_item.id}"

    expect(response).to be_successful

    invoice_item_parsed = JSON.parse(response.body)["data"]
    expect(invoice_item_parsed["attributes"]["id"]).to eq(invoice_item.id)
  end

  xit "returns a single invoice item by created_at" do
  end

  xit "returns a single invoice item by updated_at" do
  end
end
