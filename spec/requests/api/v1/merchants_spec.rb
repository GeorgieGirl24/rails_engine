require 'rails_helper'

RSpec.describe 'Merchants API' do
  it 'can send a list of merchants' do
    create_list(:merchant, 4)

    get '/api/v1/merchants'

    expect(response).to be_successful
    merchants = JSON.parse(response.body, symbolize: true)

    expect(merchant[:data].count).to eq(4)

    merchants[:data].each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_a String

      expect(merchant).to have_key(:type)
      expect(merchant[:type]).to be_a('merchant')

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a String

      expect(merchant[:attributes]).to have_key(:created_at)
      expect(merchant[:attributes][:created_at]).to be_a String

      expect(merchant[:attributes]).to have_key(:updated_at)
      expect(merchant[:attributes][:updated_at]).to be_a String
    end
  end
end
