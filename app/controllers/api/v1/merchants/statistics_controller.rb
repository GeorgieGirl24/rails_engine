class Api::V1::Merchants::StatisticsController < ApplicationController
  def most_revenue
    quantity = params[:quantity]
    render json: MerchantSerializer.new(Merchant.most_revenue(quantity))
  end

  def most_items
    quantity = params[:quantity]
    render json: MerchantSerializer.new(Merchant.most_items(quantity))
  end
end
