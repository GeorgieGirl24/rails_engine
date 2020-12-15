class Api::V1::Items::MerchantsController < ApplicationController
  def show
    # binding.pry
    render json: MerchantSerializer.new(Item.find(params[:item_id]).merchant)
  end
end
