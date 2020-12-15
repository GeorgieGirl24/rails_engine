class Api::V1::Items::SearchController < ApplicationController
  def show
    render json: ItemSerializer.new(Item.search_single(attribute, search_term))
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
