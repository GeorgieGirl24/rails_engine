class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  def create
    Item.reset_primary_key
    item = Item.new(item_params)
    return item.save ?
      (render json:ItemSerializer.new(item)) : (render status: 404)
  end

  def update
    blank_check = []
    item_params.to_h.each do |key, value|
      if value.blank?
        blank_check << nil
      else
        blank_check << 'all good'
      end
    end

    response = blank_check.all?('all good')
    if response == true
      (render json: ItemSerializer.new(Item.update({
                                                    name: params[:name],
                                                    created_at: params[:created_at],
                                                    updated_at: params[:updated_at]
                                                    })))
    else
      (render :status => 404)
    end
  end
  private

  def self.reset_primary_key
    ActiveRecord::Base.connection.reset_pk_sequence!('items')
  end

  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id, :created_at, :updated_at)
  end
end
