require 'rails_helper'

RSpec.describe 'Api::V1::Merchants::SearchController' do
  it 'can find a multiple merchant matching the search parameter' do
    merchant1 = create(:merchant, name: 'The Happily Ever Crafter')
    merchant2 = create(:merchant, name: 'The Pigeon Letters')
    merchant3 = create(:merchant, name: 'Her Name Is Mud')
    merchant4 = create(:merchant, name: 'The Best Crafter')

    attribute = :name
    search_term = 'Crafter'

    get "/api/v1/merchants/find_all?#{attribute}=#{search_term}"
    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(merchants).to be_a Array
    expect(merchants.count).to eq(2)
    merchants.each do |merchant|
      expect(merchant[:id].to_i).to eq(merchant1.id).or(eq merchant4.id)
      expect(merchant[:id].to_i).to_not eq(merchant3.id)
      expect(merchant[:id].to_i).to_not eq(merchant2.id)
      expect(merchant[:attributes][:name]).to eq(merchant1.name).or(eq merchant4.name)
      expect(merchant[:attributes][:name]).to_not eq(merchant3.name)
      expect(merchant[:attributes][:name].downcase).to include(search_term.downcase)
    end
  end

  it 'can find a single merchant matching the search parameter with all caps' do
    merchant1 = create(:merchant, name: 'The Happily Ever Crafter')
    merchant2 = create(:merchant, name: 'The Pigeon Letters')
    merchant3 = create(:merchant, name: 'Her Name Is Mud')
    merchant4 = create(:merchant, name: 'Make Pigeon Birds')

    attribute = :name
    search_term = 'PIGEON'

    get "/api/v1/merchants/find_all?#{attribute}=#{search_term}"
    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(merchants).to be_a Array
    expect(merchants.count).to eq(2)
    merchants.each do |merchant|
      expect(merchant).to be_a Hash
      expect(merchant[:id].to_i).to eq(merchant2.id).or(eq merchant4.id)
      expect(merchant[:id].to_i).to_not eq(merchant3.id)
      expect(merchant[:id].to_i).to_not eq(merchant1.id)
      expect(merchant[:type]).to eq('merchant')
      expect(merchant[:attributes][:name]).to eq(merchant2.name).or(eq merchant4.name)
      expect(merchant[:attributes][:name]).to_not eq(merchant1.name)
      expect(merchant[:attributes][:name].downcase).to include(search_term.downcase)
    end
  end

  it 'can find a single merchant matching the search parameter with part of the name' do
    merchant1 = create(:merchant, name: 'The Happily Ever Crafter')
    merchant2 = create(:merchant, name: 'The Pigeon Letters')
    merchant3 = create(:merchant, name: 'Her Name Is Mud')
    merchant4 = create(:merchant, name: 'Mud to Magic')

    attribute = :name
    search_term = 'mud'

    get "/api/v1/merchants/find_all?#{attribute}=#{search_term}"
    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(merchants).to be_a Array
    expect(merchants.count).to eq(2)
    merchants.each do |merchant|
      expect(merchant).to be_a Hash
      expect(merchant[:id].to_i).to eq(merchant3.id).or(eq merchant4.id)
      expect(merchant[:id].to_i).to_not eq(merchant2.id)
      expect(merchant[:id].to_i).to_not eq(merchant1.id)
      expect(merchant[:type]).to eq('merchant')
      expect(merchant[:attributes][:name]).to eq(merchant3.name).or(eq merchant4.name)
      expect(merchant[:attributes][:name]).to_not eq(merchant1.name)
      expect(merchant[:attributes][:name].downcase).to include(search_term.downcase)
    end
  end

  it 'can find a single merchant matching the search parameter with only middle of name' do
    merchant1 = create(:merchant, name: 'The Happily Ever Crafter')
    merchant2 = create(:merchant, name: 'The Pigeon Letters')
    merchant3 = create(:merchant, name: 'Her Name Is Mud')
    merchant4 = create(:merchant, name: 'The Best Wigeon')
    merchant_5 = create(:merchant, name: 'Not Pigeonholded Crafts')

    attribute = :name
    search_term = 'igeo'

    get "/api/v1/merchants/find_all?#{attribute}=#{search_term}"
    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(merchants).to be_a Array
    expect(merchants.count).to eq(3)

    merchants.each do |merchant|
      expect(merchant).to be_a Hash
      expect(merchant[:id].to_i).to eq(merchant2.id).or(eq merchant4.id).or(eq merchant_5.id)
      expect(merchant[:id].to_i).to_not eq(merchant3.id)
      expect(merchant[:id].to_i).to_not eq(merchant1.id)
      expect(merchant[:type]).to eq('merchant')
      expect(merchant[:attributes][:name]).to eq(merchant2.name).or(eq merchant4.name).or(eq merchant_5.name)
      expect(merchant[:attributes][:name]).to_not eq(merchant1.name)
      expect(merchant[:attributes][:name].downcase).to include(search_term.downcase)
    end
  end

  it 'can find merchants matching the search parameter with a created_at date' do
    merchant1 = create(:merchant,
                        name: 'The Happily Ever Crafter',
                        created_at: '2020-11-13')
    merchant2 = create(:merchant, name: 'The Pigeon Letters', created_at: '2020-10-13')
    merchant3 = create(:merchant, name: 'Her Name Is Mud', created_at: '2020-11-13')

    attribute = :created_at
    search_term = '2020-11-13'

    get "/api/v1/merchants/find_all?#{attribute}=#{search_term}"
    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(merchants).to be_a Array
    expect(merchants.count).to eq(2)

    merchants.each do |merchant|
      expect(merchant).to be_a Hash
      expect(merchant[:id].to_i).to eq(merchant3.id).or(eq merchant1.id)
      expect(merchant[:id].to_i).to_not eq(merchant2.id)
      expect(merchant[:type]).to eq('merchant')
      expect(merchant[:attributes][:name]).to eq(merchant3.name).or(eq merchant1.name)
      expect(merchant[:attributes][:name]).to_not eq(merchant2.name)
    end
  end
end
