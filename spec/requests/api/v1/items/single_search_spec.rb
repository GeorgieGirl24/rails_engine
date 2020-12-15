require 'rails_helper'

RSpec.describe 'Api::V1::Items::SearchController' do
  it 'can find a single item matching the search parameter' do
    item1 = create(:item, name: 'Orchid')
    item2 = create(:item, name: 'Geranium')
    item3 = create(:item, name: 'Prayer Plant')

    attribute = :name
    search_term = 'Geranium'

    get "/api/v1/items/find?#{attribute}=#{search_term}"
    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(item).to be_a Hash
    expect(item[:id].to_i).to eq(item2.id)
    expect(item[:id].to_i).to_not eq(item3.id)
    expect(item[:id].to_i).to_not eq(item1.id)
    expect(item[:attributes][:name]).to eq(item2.name)
    expect(item[:attributes][:name]).to_not eq(item1.name)
    expect(item[:attributes][:name].downcase).to include(search_term.downcase)
  end

  it 'can find a single item matching the search parameter with price' do
    item1 = create(:item, name: 'Orchid')
    item2 = create(:item, name: 'Geranium', unit_price: 12.36)
    item3 = create(:item, name: 'Prayer Plant')

    attribute = :unit_price
    search_term = 12.36

    get "/api/v1/items/find?#{attribute}=#{search_term}"
    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(item).to be_a Hash
    expect(item[:id].to_i).to eq(item2.id)
    expect(item[:id].to_i).to_not eq(item3.id)
    expect(item[:id].to_i).to_not eq(item1.id)
    expect(item[:type]).to eq('item')
    expect(item[:attributes][:name]).to eq(item2.name)
    expect(item[:attributes][:description]).to eq(item2.description)
    expect(item[:attributes][:name]).to_not eq(item1.name)
    expect(item[:attributes][:unit_price]).to eq(search_term)
  end

  it 'can find a single item matching the search with part of the name' do
    item1 = create(:item, name: 'Orchid')
    item2 = create(:item, name: 'Geranium')
    item3 = create(:item, name: 'Prayer Plant')

    attribute = :name
    search_term = 'lant'

    get "/api/v1/items/find?#{attribute}=#{search_term}"
    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(item).to be_a Hash
    expect(item[:id].to_i).to eq(item3.id)
    expect(item[:id].to_i).to_not eq(item2.id)
    expect(item[:id].to_i).to_not eq(item1.id)
    expect(item[:type]).to eq('item')
    expect(item[:attributes][:name]).to eq(item3.name)
    expect(item[:attributes][:description]).to eq(item3.description)
    expect(item[:attributes][:unit_price]).to eq(item3.unit_price)
    expect(item[:attributes][:name]).to_not eq(item1.name)
    expect(item[:attributes][:name].downcase).to include(search_term.downcase)
  end

  it 'can find an item matching the search with ALL CAPS in the description' do
    item1 = create(:item,
                   name: 'Orchid',
                   description: 'WILDLY BEAUTIFUL species of flower')
    item2 = create(:item,
                   name: 'Geranium')
    item3 = create(:item,
                   name: 'Prayer Plant')

    attribute = :description
    search_term = 'BEAUTIFUL'

    get "/api/v1/items/find?#{attribute}=#{search_term}"
    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(item).to be_a Hash
    expect(item[:id].to_i).to eq(item1.id)
    expect(item[:id].to_i).to_not eq(item2.id)
    expect(item[:id].to_i).to_not eq(item3.id)
    expect(item[:type]).to eq('item')
    expect(item[:attributes][:name]).to eq(item1.name)
    expect(item[:attributes][:name]).to_not eq(item3.name)
    results = item[:attributes][:description].downcase
    expect(results).to include(search_term.downcase)
  end

  it 'can find a single item matching the search with a created_at date' do
    item1 = create(:item,
                   name: 'Orchid',
                   created_at: '2020-12-13')
    item2 = create(:item,
                   name: 'Geranium',
                   created_at: '2020-10-13')
    item3 = create(:item,
                   name: 'Prayer Plant',
                   created_at: '2020-11-13')

    attribute = :created_at
    search_term = '2020-11-13'

    get "/api/v1/items/find?#{attribute}=#{search_term}"
    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(item).to be_a Hash
    expect(item[:id].to_i).to eq(item3.id)
    expect(item[:id].to_i).to_not eq(item2.id)
    expect(item[:id].to_i).to_not eq(item1.id)
    expect(item[:type]).to eq('item')
    expect(item[:attributes][:name]).to eq(item3.name)
  end
end
