require 'rails_helper'

describe "Customers API" do
  it "sends a list of Customers" do
    create_list(:customer, 3)

    get '/api/v1/customers'

    expect(response).to be_successful

    customers = JSON.parse(response.body)["data"]

    expect(customers.count).to eq(3)
  end

  it "can get one Customers by id" do
    customer = create(:customer)

    get "/api/v1/customers/#{customer.id}"

    expect(response).to be_successful

    customer_parsed = JSON.parse(response.body)
    expect(customer_parsed["data"]["id"]).to eq(customer.id.to_s)
  end
end
