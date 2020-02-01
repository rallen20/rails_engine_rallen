require 'rails_helper'

describe "Customers API - Search" do
  it "returns a single customer by id" do
    customer = create(:customer)

    get "/api/v1/customers/find?id=#{customer.id}"

    expect(response).to be_successful

    customer_parsed = JSON.parse(response.body)
    expect(customer_parsed["data"]["id"]).to eq(customer.id.to_s)
  end

  it "returns a single customer by first_name" do
    customer = create(:customer)

    get "/api/v1/customers/find?first_name=#{customer.first_name}"

    expect(response).to be_successful

    customer_parsed = JSON.parse(response.body)
    expect(customer_parsed["data"]["id"]).to eq(customer.id.to_s)
  end

  it "returns a single customer by last_name" do
    customer = create(:customer)

    get "/api/v1/customers/find?last_name=#{customer.last_name}"

    expect(response).to be_successful

    customer_parsed = JSON.parse(response.body)
    expect(customer_parsed["data"]["id"]).to eq(customer.id.to_s)
  end

  xit "returns a single customer by created_at" do
  end

  xit "returns a single customer by updated_at" do
  end
end
