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

  it "returns a single invoice item by created_at" do
    invoice = create(:invoice, created_at: "2010-01-01 00:00:00 UTC")
    get "/api/v1/invoices/find?created_at=2010-01-01"

    expect(response).to be_successful

    invoice_parsed = JSON.parse(response.body)
    expect(invoice_parsed["data"]["id"]).to eq(invoice.id.to_s)
  end

  it "returns a single invoice item by updated_at" do
    invoice = create(:invoice, updated_at: "2010-01-01 00:00:00 UTC")
    get "/api/v1/invoices/find?updated_at=2010-01-01"

    expect(response).to be_successful

    invoice_parsed = JSON.parse(response.body)
    expect(invoice_parsed["data"]["id"]).to eq(invoice.id.to_s)
  end

  it "returns all invoice item by id" do
    invoice_item = create(:invoice_item)
    invoice_item_2 = create(:invoice_item)

    get "/api/v1/invoice_items/find_all?id=#{invoice_item.id}"

    expect(response).to be_successful

    invoice_item_parsed = JSON.parse(response.body)["data"]
    expect(invoice_item_parsed.count).to eq(1)
  end
end
