require 'rails_helper'

RSpec.describe TotalRevenue, type: :model do
  it "test total revenue can be created" do
    total_revenue = TotalRevenue.new(1031.25)
    expect(total_revenue).to be_instance_of(TotalRevenue)
    expect(total_revenue.total_revenue).to eq(1031.25)
  end
end
