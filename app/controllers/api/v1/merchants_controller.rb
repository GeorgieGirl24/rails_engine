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

  def update
    blank_check = []
    merchant_params.to_h.each do |key, value|
      if value.blank?
        blank_check << nil
      else
        blank_check << 'all good'
      end
    end

    response = blank_check.all?('all good')
    if response == true
      (render json: MerchantSerializer.new(Merchant.update({
                                                            name: params[:name],
                                                            created_at: params[:created_at],
                                                            updated_at: params[:updated_at]
                                                            })))
    else
      (render :status => 404)
    end
  end

  def destroy
    if merchant = Merchant.find(params[:id])
      merchant.destroy
    else
      (render :status => 404)
    end
  end

  private

  def self.reset_primary_key
    ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
  end

  def merchant_params
    params.permit(:name, :created_at, :updated_at)
  end
end
