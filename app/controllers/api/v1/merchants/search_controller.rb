class Api::V1::Merchants::SearchController < ApplicationController
  def show
    render json: MerchantSerializer.new(Merchant.search_single(merchant_params))
  end

  private

  def merchant_params
    params.permit(:name, :created_at, :updated_at)
  end
end
