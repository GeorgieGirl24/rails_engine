class Api::V1::RevenueController < ApplicationController
  def index
    revenue = RevenueFacade.total_revenue(params[:start], params[:end])
    if revenue.revenue > 0.00
      render json: RevenueSerializer.new(revenue)
    else

    end
  end
end
