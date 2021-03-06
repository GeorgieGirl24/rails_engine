require 'rails_helper'

RSpec.describe 'Merchants relationship with all its items' do
  it 'can return all the associated items of a Merchant' do
    merchant1 = create(:merchant, :with_items, items: 5)
    merchant2 = create(:merchant, :with_items, items: 6)
    id = merchant1.id
    get "/api/v1/merchants/#{id}/items"

    expect(response).to be_successful
    items = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(Item.all.count).to eq(11)
    expect(items.count).to eq(5)

    items.each do |item|
      expect(item).to have_key :id
      expect(item[:id]).to be_a String

      expect(item).to have_key :type
      expect(item[:type]).to eq 'item'

      expect(item[:attributes]).to have_key :name
      expect(item[:attributes][:name]).to be_a String

      expect(item[:attributes]).to have_key :description
      expect(item[:attributes][:description]).to be_a String

      expect(item[:attributes]).to have_key :unit_price
      expect(item[:attributes][:unit_price]).to be_a Float

      expect(item[:attributes]).to have_key :merchant_id
      expect(item[:attributes][:merchant_id]).to be_a Integer
    end
  end

  it 'cannot return items that a Merchant does not have' do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    id = merchant1.id
    get "/api/v1/merchants/#{id}/items"

    expect(response).to be_successful
    items = JSON.parse(response.body, symbolize_names: true)[:data]
  
    expect(items).to eq([])
  end
end
