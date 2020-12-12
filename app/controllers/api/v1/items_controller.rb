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

  private

  def self.reset_primary_key
    ActiveRecord::Base.connection.reset_pk_sequence!('items')
  end

  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id, :created_at, :updated_at)
  end
end
