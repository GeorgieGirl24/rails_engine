class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    render json: MerchantSerializer.new(Merchant.find(params[:id]))
  end

  def create
    Merchant.reset_primary_key
    merchant = Merchant.new(merchant_params)
    return merchant.save ?
      (render json: MerchantSerializer.new(merchant)) : (render :status => 404)
  end

  private

  def self.reset_primary_key
    ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
  end

  def merchant_params
    params.permit(:name, :created_at, :updated_at)
  end
end
