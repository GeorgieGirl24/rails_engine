class Revenue
  attr_reader :revenue, :id
  def initialize(total_revenue)
    @revenue = total_revenue.round(2)
    @id = nil
  end
end
