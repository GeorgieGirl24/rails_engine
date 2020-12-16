require 'rails_helper'

RSpec.describe 'Revenue' do
  it 'exists and has attributes' do
    total = 12_000.50
    total_revenue = Revenue.new(total)
    expect(total_revenue).to be_a Revenue
    expect(total_revenue.revenue).to eq(total)
    expect(total_revenue.revenue).to_not eq(nil)
    expect(total_revenue.revenue).to_not eq(11_000.00)
    expect(total_revenue.revenue).to_not eq(12_000)
    expect(total_revenue.revenue).to be_a Float
    expect(total_revenue.id).to eq(nil)
  end
end
