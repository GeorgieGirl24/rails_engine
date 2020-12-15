require 'rails_helper'

RSpec.describe 'Api::V1::Items::SearchController' do
  it 'can find a single item matching the search parameter' do
    item_1 = create(:item, name: 'Orchid')
    item_2 = create(:item, name: 'Geranium')
    item_3 = create(:item, name: 'Prayer Plant')

    attribute = :name
    search_term = 'Geranium'

    get "/api/v1/items/find?#{attribute}=#{search_term}"
    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)[:data]
    item = json.last
    expect(item).to be_a Hash
    expect(item[:id].to_i).to eq(item_2.id)
    expect(item[:id].to_i).to_not eq(item_3.id)
    expect(item[:id].to_i).to_not eq(item_1.id)
    expect(item[:attributes][:name]).to eq(item_2.name)
    expect(item[:attributes][:name]).to_not eq(item_1.name)
    expect(item[:attributes][:name].downcase).to include(search_term.downcase)
  end

  it 'can find a single item matching the search parameter with price' do
    item_1 = create(:item, name: 'Orchid')
    item_2 = create(:item, name: 'Geranium', unit_price: 12.36)
    item_3 = create(:item, name: 'Prayer Plant')

    attribute = :unit_price
    search_term = 12.36

    get "/api/v1/items/find?#{attribute}=#{search_term}"
    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)[:data]
    item = json.last

    expect(item).to be_a Hash
    expect(item[:id].to_i).to eq(item_2.id)
    expect(item[:id].to_i).to_not eq(item_3.id)
    expect(item[:id].to_i).to_not eq(item_1.id)
    expect(item[:type]).to eq('item')
    expect(item[:attributes][:name]).to eq(item_2.name)
    expect(item[:attributes][:description]).to eq(item_2.description)
    expect(item[:attributes][:name]).to_not eq(item_1.name)
    expect(item[:attributes][:unit_price]).to eq(search_term)
  end

  it 'can find a single item matching the search parameter with part of the name' do
    item_1 = create(:item, name: 'Orchid')
    item_2 = create(:item, name: 'Geranium')
    item_3 = create(:item, name: 'Prayer Plant')

    attribute = :name
    search_term = 'lant'

    get "/api/v1/items/find?#{attribute}=#{search_term}"
    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)[:data]
    item = json.last

    expect(item).to be_a Hash
    expect(item[:id].to_i).to eq(item_3.id)
    expect(item[:id].to_i).to_not eq(item_2.id)
    expect(item[:id].to_i).to_not eq(item_1.id)
    expect(item[:type]).to eq('item')
    expect(item[:attributes][:name]).to eq(item_3.name)
    expect(item[:attributes][:description]).to eq(item_3.description)
    expect(item[:attributes][:unit_price]).to eq(item_3.unit_price)
    expect(item[:attributes][:name]).to_not eq(item_1.name)
    expect(item[:attributes][:name].downcase).to include(search_term.downcase)
  end

  it 'can find a single item matching the search parameter with ALL CAPS in part of the description' do
    item_1 = create(:item, name: 'Orchid', description: 'WILDLY BEAUTIFUL species of flower')
    item_2 = create(:item, name: 'Geranium')
    item_3 = create(:item, name: 'Prayer Plant')

    attribute = :description
    search_term = 'BEAUTIFUL'

    get "/api/v1/items/find?#{attribute}=#{search_term}"
    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)[:data]
    item = json.last

    expect(item).to be_a Hash
    expect(item[:id].to_i).to eq(item_1.id)
    expect(item[:id].to_i).to_not eq(item_2.id)
    expect(item[:id].to_i).to_not eq(item_3.id)
    expect(item[:type]).to eq('item')
    expect(item[:attributes][:name]).to eq(item_1.name)
    expect(item[:attributes][:name]).to_not eq(item_3.name)
    expect(item[:attributes][:description].downcase).to include(search_term.downcase)
  end

  it 'can find a single item matching the search parameter with a created_at date' do
    item_1 = create(:item,
                    name: 'Orchid',
                    created_at: '2020-12-13')
    item_2 = create(:item,
                    name: 'Geranium',
                    created_at: '2020-10-13')
    item_3 = create(:item,
                    name: 'Prayer Plant',
                    created_at: '2020-11-13')

    attribute = :created_at
    search_term = '2020-11-13'

    get "/api/v1/items/find?#{attribute}=#{search_term}"
    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)[:data]
    item = json.last
    expect(item).to be_a Hash
    expect(item[:id].to_i).to eq(item_3.id)
    expect(item[:id].to_i).to_not eq(item_2.id)
    expect(item[:id].to_i).to_not eq(item_1.id)
    expect(item[:type]).to eq('item')
    expect(item[:attributes][:name]).to eq(item_3.name)
  end
end
