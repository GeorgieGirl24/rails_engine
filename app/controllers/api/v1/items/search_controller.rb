class Api::V1::Items::SearchController < ApplicationController
  def show
    if item_params[:name] || item_params[:description]
      render json: ItemSerializer.new(Item.search_single(item_params))
    elsif item_params[:created_at] || item_params[:updated_at]
      render json: ItemSerializer.new(Item.search_date(item_params))
    else
      render json: ItemSerializer.new(Item.unit_price_search(item_params))
    end
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price, :created_at, :updated_at)
  end
end
