class Revenue
  attr_reader :revenue, :id
  def initialize(total_revenue)
    @revenue = total_revenue
    @id = nil
  end
end
