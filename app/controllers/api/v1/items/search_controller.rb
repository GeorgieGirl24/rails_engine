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

  def index
    render json: ItemSerializer.new(Item.search_multiple(attribute, search_term))
  end

  private

  def attribute
    item_params.keys.first
  end

  def search_term
    item_params[attribute]
  end

  def item_params
    params.permit(:name, :description, :unit_price, :created_at, :updated_at)
  end
end
