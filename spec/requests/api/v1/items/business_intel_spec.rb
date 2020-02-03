require 'rails_helper'

describe "Items API - Business Intel" do
  it "returns the top x items ranked by total revenue generated" do
    item_1 = create(:item)
    invoice_1 = create(:invoice)
    invoice_item_1 = create(:invoice_item,
      item: item_1,
      invoice: invoice_1,
      quantity: 2,
      unit_price: 100)

    item_2 = create(:item)
    invoice_2 = create(:invoice)
    invoice_21 = create(:invoice)
    invoice_item_2 = create(:invoice_item,
      item: item_2,
      invoice: invoice_2,
      quantity: 3,
      unit_price: 100)
    invoice_item_21 = create(:invoice_item,
      item: item_2,
      invoice: invoice_21,
      quantity: 5,
      unit_price: 100)

    item_3 = create(:item)
    invoice_3 = create(:invoice)
    invoice_item_3 = create(:invoice_item,
      item: item_3,
      invoice: invoice_3,
      quantity: 1,
      unit_price: 100)

    item_4 = create(:item)
    invoice_4 = create(:invoice)
    invoice_item_4 = create(:invoice_item,
      item: item_4,
      invoice: invoice_4,
      quantity: 5,
      unit_price: 100)

    create(:transaction, invoice: invoice_1, result: 'success')
    create(:transaction, invoice: invoice_2, result: 'success')
    create(:transaction, invoice: invoice_21, result: 'success')
    create(:transaction, invoice: invoice_3, result: 'success')
    create(:transaction, invoice: invoice_4, result: 'success')

    get "/api/v1/items/most_revenue?quantity=3"

    expect(response).to be_successful

    top_items = JSON.parse(response.body)
    expect(top_items["data"].count).to eq(3)
    expect(top_items["data"].first["id"]).to eq(item_2.id.to_s)
  end

  it "returns the date with the most sales for the given item using the invoice date" do
    item = create(:item)
    invoice_1 = create(:invoice, created_at: "2010-01-01 00:00:00 UTC")
    create(:invoice_item, item: item, invoice: invoice_1)
    transaction_1 = create(:transaction, result: 'success', invoice: invoice_1)
    invoice_2 = create(:invoice)
    get "/api/v1/items/#{item.id}/best_day"

    expect(response).to be_successful
    date_parsed = JSON.parse(response.body)
    expect(date_parsed["data"]["attributes"]["best_day"]).to eq("2010-01-01")
  end
end
