require 'rails_helper'

RSpec.describe 'Api::V1::Merchants::SearchController' do
  it 'can find a single merchant matching the search parameter' do
    merchant_1 = create(:merchant, name: 'The Happily Ever Crafter')
    merchant_2 = create(:merchant, name: 'The Pigeon Letters')
    merchant_3 = create(:merchant, name: 'Her Name Is Mud')

    attribute = :name
    search_term = 'Pigeon'

    get "/api/v1/merchants/find?#{attribute}=#{search_term}"
    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)[:data]
    # binding.pry
    merchant = json.last
    expect(merchant).to be_a Hash
    expect(merchant[:id].to_i).to eq(merchant_2.id)
    expect(merchant[:id].to_i).to_not eq(merchant_3.id)
    expect(merchant[:id].to_i).to_not eq(merchant_1.id)
    expect(merchant[:attributes][:name]).to eq(merchant_2.name)
    expect(merchant[:attributes][:name]).to_not eq(merchant_1.name)
    expect(merchant[:attributes][:name].downcase).to include(search_term.downcase)
  end

  it 'can find a single merchant matching the search parameter with all caps' do
    merchant_1 = create(:merchant, name: 'The Happily Ever Crafter')
    merchant_2 = create(:merchant, name: 'The Pigeon Letters')
    merchant_3 = create(:merchant, name: 'Her Name Is Mud')

    attribute = :name
    search_term = 'PIGEON'

    get "/api/v1/merchants/find?#{attribute}=#{search_term}"
    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)[:data]
    merchant = json.last

    expect(merchant).to be_a Hash
    expect(merchant[:id].to_i).to eq(merchant_2.id)
    expect(merchant[:id].to_i).to_not eq(merchant_3.id)
    expect(merchant[:id].to_i).to_not eq(merchant_1.id)
    expect(merchant[:type]).to eq('merchant')
    expect(merchant[:attributes][:name]).to eq(merchant_2.name)
    expect(merchant[:attributes][:name]).to_not eq(merchant_1.name)
    expect(merchant[:attributes][:name].downcase).to include(search_term.downcase)
  end

  it 'can find a single merchant matching the search parameter with part of the name' do
    merchant_1 = create(:merchant, name: 'The Happily Ever Crafter')
    merchant_2 = create(:merchant, name: 'The Pigeon Letters')
    merchant_3 = create(:merchant, name: 'Her Name Is Mud')

    attribute = :name
    search_term = 'pig'

    get "/api/v1/merchants/find?#{attribute}=#{search_term}"
    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)[:data]
    merchant = json.last

    expect(merchant).to be_a Hash
    expect(merchant[:id].to_i).to eq(merchant_2.id)
    expect(merchant[:id].to_i).to_not eq(merchant_3.id)
    expect(merchant[:id].to_i).to_not eq(merchant_1.id)
    expect(merchant[:type]).to eq('merchant')
    expect(merchant[:attributes][:name]).to eq(merchant_2.name)
    expect(merchant[:attributes][:name]).to_not eq(merchant_1.name)
    expect(merchant[:attributes][:name].downcase).to include(search_term.downcase)
  end

  it 'can find a single merchant matching the search parameter with only middle of name' do
    merchant_1 = create(:merchant, name: 'The Happily Ever Crafter')
    merchant_2 = create(:merchant, name: 'The Pigeon Letters')
    merchant_3 = create(:merchant, name: 'Her Name Is Mud')

    attribute = :name
    search_term = 'igeo'

    get "/api/v1/merchants/find?#{attribute}=#{search_term}"
    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)[:data]
    merchant = json.last

    expect(merchant).to be_a Hash
    expect(merchant[:id].to_i).to eq(merchant_2.id)
    expect(merchant[:id].to_i).to_not eq(merchant_3.id)
    expect(merchant[:id].to_i).to_not eq(merchant_1.id)
    expect(merchant[:type]).to eq('merchant')
    expect(merchant[:attributes][:name]).to eq(merchant_2.name)
    expect(merchant[:attributes][:name]).to_not eq(merchant_1.name)
    expect(merchant[:attributes][:name].downcase).to include(search_term.downcase)
  end

  it 'can find a single merchant matching the search parameter with a created_at date' do
    merchant_1 = create(:merchant,
                        name: 'The Happily Ever Crafter',
                        created_at: '2020-12-13')
    merchant_2 = create(:merchant, name: 'The Pigeon Letters', created_at: '2020-10-13')
    merchant_3 = create(:merchant, name: 'Her Name Is Mud', created_at: '2020-11-13')

    attribute = :created_at
    # search_term = '2020-11-13T06:13:28.643Z'
    search_term = '2020-11-13'

    get "/api/v1/merchants/find?#{attribute}=#{search_term}"
    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)[:data]
    merchant = json.last
# binding.pry
    expect(merchant).to be_a Hash
    expect(merchant[:id].to_i).to eq(merchant_3.id)
    expect(merchant[:id].to_i).to_not eq(merchant_2.id)
    expect(merchant[:id].to_i).to_not eq(merchant_1.id)
    expect(merchant[:type]).to eq('merchant')
    expect(merchant[:attributes][:name]).to eq(merchant_3.name)
  end
end
