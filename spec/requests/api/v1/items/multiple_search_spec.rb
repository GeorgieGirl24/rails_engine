require 'rails_helper'

RSpec.describe 'Api::V1::Items::SearchController' do
  it 'can find multiple items matching the search parameter' do
    item_1 = create(:item, name: 'Orchid')
    item_2 = create(:item, name: 'Geranium')
    item_3 = create(:item, name: 'Prayer Plant')
    item_4 = create(:item, name: 'Pink Orchid')

    attribute = :name
    search_term = 'Orchid'

    get "/api/v1/items/find_all?#{attribute}=#{search_term}"
    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(items).to be_a Array
    expect(items.count).to eq(2)
    items.each do |item|
      expect(item).to be_a Hash
      expect(item[:id].to_i).to eq(item_1.id).or(eq item_4.id)
      expect(item[:id].to_i).to_not eq(item_3.id)
      expect(item[:id].to_i).to_not eq(item_2.id)
      expect(item[:attributes][:name]).to eq(item_1.name).or(eq item_4.name)
      expect(item[:attributes][:name]).to_not eq(item_2.name)
      expect(item[:attributes][:name].downcase).to include(search_term.downcase)
    end
  end

  it 'can find multiple items matching the search parameter with all caps' do
    item_1 = create(:item, name: 'Orchid')
    item_2 = create(:item, name: 'Geranium', unit_price: 12.36)
    item_3 = create(:item, name: 'Prayer Plant')
    item_4 = create(:item, name: 'Fiddleleaf', unit_price: 12.36)

    attribute = :unit_price
    search_term = 12.36

    get "/api/v1/items/find_all?#{attribute}=#{search_term}"
    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(items).to be_a Array
    expect(items.count).to eq(2)
    items.each do |item|
      expect(item).to be_a Hash
      expect(item[:id].to_i).to eq(item_2.id).or(eq item_4.id)
      expect(item[:id].to_i).to_not eq(item_3.id)
      expect(item[:id].to_i).to_not eq(item_1.id)
      expect(item[:type]).to eq('item')
      expect(item[:attributes][:name]).to eq(item_2.name).or(eq item_4.name)
      expect(item[:attributes][:description]).to eq(item_2.description).or(eq item_4.description)
      expect(item[:attributes][:name]).to_not eq(item_1.name)
      expect(item[:attributes][:unit_price]).to eq(search_term)
    end
  end

  it 'can find multiple items matching the search parameter with part of the name' do
    item_1 = create(:item, name: 'Orchid')
    item_2 = create(:item, name: 'Geranium')
    item_3 = create(:item, name: 'Prayer Plant')
    item_4 = create(:item, name: 'Tall Plant')

    attribute = :name
    search_term = 'lant'

    get "/api/v1/items/find_all?#{attribute}=#{search_term}"
    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(items).to be_a Array
    expect(items.count).to eq(2)
    items.each do |item|
      expect(item).to be_a Hash
      expect(item[:id].to_i).to eq(item_3.id).or(eq item_4.id)
      expect(item[:id].to_i).to_not eq(item_2.id)
      expect(item[:id].to_i).to_not eq(item_1.id)
      expect(item[:type]).to eq('item')
      expect(item[:attributes][:name]).to eq(item_3.name).or(eq item_4.name)
      expect(item[:attributes][:description]).to eq(item_3.description).or(eq item_4.description)
      expect(item[:attributes][:unit_price]).to eq(item_3.unit_price).or(eq item_4.unit_price)
      expect(item[:attributes][:name]).to_not eq(item_1.name)
      expect(item[:attributes][:name].downcase).to include(search_term.downcase)
    end
  end

  it 'can find multiple items matching the search parameter with only middle of name' do
    item_1 = create(:item,
                    name: 'Orchid',
                    description: 'WILDLY BEAUTIFUL species of flower')
    item_2 = create(:item,
                    name: 'Geranium')
    item_3 = create(:item, name: 'Prayer Plant',
                    description: 'Beautiful leaves')
    item_4 = create(:item,
                    name: 'Cone Flowers',
                    description: 'Beautiful flowers that attract bees')

    attribute = :description
    search_term = 'BEAUTIFUL'

    get "/api/v1/items/find_all?#{attribute}=#{search_term}"
    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(items).to be_a Array
    expect(items.count).to eq(3)

    items.each do |item|
      expect(item).to be_a Hash
      expect(item[:id].to_i).to eq(item_1.id).or(eq item_3.id).or(eq item_4.id)
      expect(item[:id].to_i).to_not eq(item_2.id)
      expect(item[:type]).to eq('item')
      expect(item[:attributes][:name]).to eq(item_1.name).or(eq item_3.name).or(eq item_4.name)
      expect(item[:attributes][:name]).to_not eq(item_2.name)
      expect(item[:attributes][:description]).to eq(item_1.description).or(eq item_3.description).or(eq item_4.description)
      expect(item[:attributes][:unit_price]).to eq(item_1.unit_price).or(eq item_3.unit_price).or(eq item_4.unit_price)
      expect(item[:attributes][:description].downcase).to include(search_term.downcase)
    end
  end

  it 'can find multiple items matching the search parameter with a created_at date' do
    item_1 = create(:item,
                    name: 'Orchid',
                    created_at: '2020-12-13')
    item_2 = create(:item,
                    name: 'Geranium',
                    created_at: '2020-10-13')
    item_3 = create(:item,
                    name: 'Prayer Plant',
                    created_at: '2020-10-13')

    attribute = :created_at
    search_term = '2020-10-13'

    get "/api/v1/items/find_all?#{attribute}=#{search_term}"
    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(items).to be_a Array
    expect(items.count).to eq(2)

    items.each do |item|
      expect(item).to be_a Hash
      expect(item[:id].to_i).to eq(item_3.id).or(eq item_2.id)
      expect(item[:id].to_i).to_not eq(item_1.id)
      expect(item[:type]).to eq('item')
      expect(item[:attributes][:name]).to eq(item_3.name).or(eq item_2.name)
      expect(item[:attributes][:description]).to eq(item_3.description).or(eq item_2.description)
      expect(item[:attributes][:unit_price]).to eq(item_3.unit_price).or(eq item_2.unit_price)
    end
  end
end
