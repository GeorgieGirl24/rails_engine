require 'rails_helper'

RSpec.describe 'Api::V1::Merchants::SearchController' do
  it 'can find a single merchant matching the search parameter' do
    merchant1 = create(:merchant, name: 'The Happily Ever Crafter')
    merchant2 = create(:merchant, name: 'The Pigeon Letters')
    merchant3 = create(:merchant, name: 'Her Name Is Mud')

    attribute = :name
    search_term = 'Pigeon'

    get "/api/v1/merchants/find?#{attribute}=#{search_term}"
    expect(response).to be_successful

    merchant = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(merchant).to be_a Hash
    expect(merchant[:id].to_i).to eq(merchant2.id)
    expect(merchant[:id].to_i).to_not eq(merchant3.id)
    expect(merchant[:id].to_i).to_not eq(merchant1.id)
    expect(merchant[:attributes][:name]).to eq(merchant2.name)
    expect(merchant[:attributes][:name]).to_not eq(merchant1.name)
    expect(merchant[:attributes][:name].downcase).to include(search_term.downcase)
  end

  it 'can find a single merchant matching the search parameter with all caps' do
    merchant1 = create(:merchant, name: 'The Happily Ever Crafter')
    merchant2 = create(:merchant, name: 'The Pigeon Letters')
    merchant3 = create(:merchant, name: 'Her Name Is Mud')

    attribute = :name
    search_term = 'PIGEON'

    get "/api/v1/merchants/find?#{attribute}=#{search_term}"
    expect(response).to be_successful

    merchant = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(merchant).to be_a Hash
    expect(merchant[:id].to_i).to eq(merchant2.id)
    expect(merchant[:id].to_i).to_not eq(merchant3.id)
    expect(merchant[:id].to_i).to_not eq(merchant1.id)
    expect(merchant[:type]).to eq('merchant')
    expect(merchant[:attributes][:name]).to eq(merchant2.name)
    expect(merchant[:attributes][:name]).to_not eq(merchant1.name)
    expect(merchant[:attributes][:name].downcase).to include(search_term.downcase)
  end

  it 'can find a single merchant matching the search with part of the name' do
    merchant1 = create(:merchant, name: 'The Happily Ever Crafter')
    merchant2 = create(:merchant, name: 'The Pigeon Letters')
    merchant3 = create(:merchant, name: 'Her Name Is Mud')

    attribute = :name
    search_term = 'pig'

    get "/api/v1/merchants/find?#{attribute}=#{search_term}"
    expect(response).to be_successful

    merchant = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(merchant).to be_a Hash
    expect(merchant[:id].to_i).to eq(merchant2.id)
    expect(merchant[:id].to_i).to_not eq(merchant3.id)
    expect(merchant[:id].to_i).to_not eq(merchant1.id)
    expect(merchant[:type]).to eq('merchant')
    expect(merchant[:attributes][:name]).to eq(merchant2.name)
    expect(merchant[:attributes][:name]).to_not eq(merchant1.name)
    expect(merchant[:attributes][:name].downcase).to include(search_term.downcase)
  end

  it 'can find a merchant matching the search with only middle of name' do
    merchant1 = create(:merchant, name: 'The Happily Ever Crafter')
    merchant2 = create(:merchant, name: 'The Pigeon Letters')
    merchant3 = create(:merchant, name: 'Her Name Is Mud')

    attribute = :name
    search_term = 'igeo'

    get "/api/v1/merchants/find?#{attribute}=#{search_term}"
    expect(response).to be_successful

    merchant = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(merchant).to be_a Hash
    expect(merchant[:id].to_i).to eq(merchant2.id)
    expect(merchant[:id].to_i).to_not eq(merchant3.id)
    expect(merchant[:id].to_i).to_not eq(merchant1.id)
    expect(merchant[:type]).to eq('merchant')
    expect(merchant[:attributes][:name]).to eq(merchant2.name)
    expect(merchant[:attributes][:name]).to_not eq(merchant1.name)
    expect(merchant[:attributes][:name].downcase).to include(search_term.downcase)
  end

  it 'can find a single merchant matching the search with a created_at date' do
    merchant1 = create(:merchant,
                       name: 'The Happily Ever Crafter',
                       created_at: '2020-12-13')
    merchant2 = create(:merchant,
                       name: 'The Pigeon Letters',
                       created_at: '2020-10-13')
    merchant3 = create(:merchant,
                       name: 'Her Name Is Mud',
                       created_at: '2020-11-13')

    attribute = :created_at
    search_term = '2020-11-13'

    get "/api/v1/merchants/find?#{attribute}=#{search_term}"
    expect(response).to be_successful

    merchant = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(merchant).to be_a Hash
    expect(merchant[:id].to_i).to eq(merchant3.id)
    expect(merchant[:id].to_i).to_not eq(merchant2.id)
    expect(merchant[:id].to_i).to_not eq(merchant1.id)
    expect(merchant[:type]).to eq('merchant')
    expect(merchant[:attributes][:name]).to eq(merchant3.name)
  end

  it 'cannot find a merchant not matching the search with a created_at date' do
    merch1 = create(:merchant,
                        name: 'The Happily Ever Crafter',
                        created_at: '2020-11-13')
    merch2 = create(:merchant, name: 'The Pigeon Letters', created_at: '2020-10-13')
    merch3 = create(:merchant, name: 'Her Name Is Mud', created_at: '2020-11-13')

    attribute = :created_at
    search_term = '2019-11-13'

    get "/api/v1/merchants/find?#{attribute}=#{search_term}"
    no_merchant = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(no_merchant).to eq(nil)
  end
end
