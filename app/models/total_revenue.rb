class TotalRevenue
  attr_accessor :total_revenue, :id

  def initialize(total_revenue)
    @total_revenue = total_revenue.to_s
    @id = 1
  end
end
