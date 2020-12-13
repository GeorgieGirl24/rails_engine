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

    json = JSON.parse(response.body, symbolic: true)['data']
    merchant = json.last
    expect(merchant).to be_a Hash
    expect(merchant['id'].to_i).to eq(merchant_2.id)
    expect(merchant['id'].to_i).to_not eq(merchant_3.id)
    expect(merchant['id'].to_i).to_not eq(merchant_1.id)
    expect(merchant['attributes']['name']).to eq(merchant_2.name)
    expect(merchant['attributes']['name']).to_not eq(merchant_1.name)
    expect(merchant['attributes']['name'].downcase).to include(search_term.downcase)
    # binding.pry
  end

  it 'can find a single merchant matching the search parameter with all caps' do
    merchant_1 = create(:merchant, name: 'The Happily Ever Crafter')
    merchant_2 = create(:merchant, name: 'The Pigeon Letters')
    merchant_3 = create(:merchant, name: 'Her Name Is Mud')

    attribute = :name
    search_term = 'PIGEON'

    get "/api/v1/merchants/find?#{attribute}=#{search_term}"
    expect(response).to be_successful

    json = JSON.parse(response.body, symbolic: true)['data']
    merchant = json.last

    expect(merchant).to be_a Hash
    expect(merchant['id'].to_i).to eq(merchant_2.id)
    expect(merchant['id'].to_i).to_not eq(merchant_3.id)
    expect(merchant['id'].to_i).to_not eq(merchant_1.id)
    expect(merchant['type']).to eq('merchant')
    expect(merchant['attributes']['name']).to eq(merchant_2.name)
    expect(merchant['attributes']['name']).to_not eq(merchant_1.name)
    expect(merchant['attributes']['name'].downcase).to include(search_term.downcase)
  end
end
