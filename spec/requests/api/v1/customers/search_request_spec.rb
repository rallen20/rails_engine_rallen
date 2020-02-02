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

  it "returns a single customer by created_at" do
    customer = create(:customer, created_at: "2010-01-01 00:00:00 UTC")
    get "/api/v1/customers/find?created_at=2010-01-01"

    expect(response).to be_successful

    customer_parsed = JSON.parse(response.body)
    expect(customer_parsed["data"]["id"]).to eq(customer.id.to_s)
  end

  it "returns a single customer by updated_at" do
    customer = create(:customer, updated_at: "2010-01-01 00:00:00 UTC")
    get "/api/v1/customers/find?updated_at=2010-01-01"

    expect(response).to be_successful

    customer_parsed = JSON.parse(response.body)
    expect(customer_parsed["data"]["id"]).to eq(customer.id.to_s)
  end

  # find_all
  it "returns all customers by id" do
    customer = create(:customer)
    create_list(:customer, 3)

    get "/api/v1/customers/find_all?id=#{customer.id}"

    expect(response).to be_successful

    customer_parsed = JSON.parse(response.body)
    expect(customer_parsed["data"].count).to eq(1)
  end

  it "returns all customers by first_name" do
    customers = create_list(:customer, 3, first_name: "Ry")

    get "/api/v1/customers/find_all?first_name=#{customers.first.first_name}"

    expect(response).to be_successful

    customer_parsed = JSON.parse(response.body)
    expect(customer_parsed["data"].count).to eq(3)
  end

  it "returns all customers by last_name" do
    customers = create_list(:customer, 2, last_name: "Al")


    get "/api/v1/customers/find_all?last_name=#{customers.first.last_name}"

    expect(response).to be_successful

    customer_parsed = JSON.parse(response.body)
    expect(customer_parsed["data"].count).to eq(2)
  end

  it "returns all customers by created_at" do
    create_list(:customer, 3, created_at: "2010-03-01 00:00:00 UTC")
    get "/api/v1/customers/find_all?created_at=2010-03-01"

    expect(response).to be_successful

    customer_parsed = JSON.parse(response.body)
    expect(customer_parsed["data"].count).to eq(3)
  end

  it "returns all customers by updated_at" do
    create_list(:customer, 2, updated_at: "2010-02-01 00:00:00 UTC")
    get "/api/v1/customers/find_all?updated_at=2010-02-01"

    expect(response).to be_successful

    customer_parsed = JSON.parse(response.body)
    expect(customer_parsed["data"].count).to eq(2)
  end
end
