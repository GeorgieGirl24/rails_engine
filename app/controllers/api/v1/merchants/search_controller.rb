class Api::V1::Merchants::SearchController < ApplicationController
  def show
    render json: MerchantSerializer.new(Merchant.search_single(attribute, search_term))
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
