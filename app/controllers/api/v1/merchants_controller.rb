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
    if merchant.save
      (render json: MerchantSerializer.new(merchant))
    else
      (render status: 404)
    end
  end

  def update
    if check_params == 3
      render json: MerchantSerializer.new(Merchant.update(params[:id], merchant_params))
    else
      render status: 404
    end
  end

  def destroy
    if Merchant.exists?(params[:id])
       Merchant.destroy(params[:id])
    else
      (render status: 404)
    end
  end

  private

  def check_params
    number_params = merchant_params.reject do |attribute, search|
      search.blank?
    end
    number_params.to_h.count
  end

  def self.reset_primary_key
    ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
  end

  def merchant_params
    params.permit(:name, :created_at, :updated_at)
  end
end
