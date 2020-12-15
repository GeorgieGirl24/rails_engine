class Api::V1::Merchants::SearchController < ApplicationController
  def show
    if merchant_params[:name]
      render json: MerchantSerializer.new(Merchant.search_single(merchant_params))
    else merchant_params[:created_at] || merchant_params[:updated_at]
      render json: MerchantSerializer.new(Merchant.search_date(merchant_params))
    end
  end

  def index
    render json: MerchantSerializer.new(Merchant.search_multiple(attribute, search_term))
  end
  
  private

  def attribute
    merchant_params.keys.first
  end

  def search_term
    merchant_params[attribute]
  end

  def merchant_params
    params.permit(:name, :created_at, :updated_at)
  end
end
