require 'rails_helper'

RSpec.describe 'Merchants API' do
  it 'can send a list of merchants' do
    create_list(:merchant, 4)

    get '/api/v1/merchants'

    expect(response).to be_successful
    merchants = JSON.parse(response.body, symbolize: true)

    expect(merchants['data'].count).to eq(4)

    merchants['data'].each do |merchant|
      expect(merchant).to have_key('id')
      expect(merchant['id']).to be_a String

      expect(merchant).to have_key('type')
      expect(merchant['type']).to eq('merchant')

      expect(merchant['attributes']).to have_key('name')
      expect(merchant['attributes']['name']).to be_a String
    end
  end

  it 'can send a unique merchant information' do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body, symbolize: true)

    expect(response).to be_successful
    expect(merchant).to be_a Hash

    expect(merchant['data']).to have_key('id')
    expect(merchant['data']['id']).to be_a String

    expect(merchant['data']).to have_key('type')
    expect(merchant['data']['type']).to eq('merchant')

    expect(merchant['data']['attributes']).to have_key('name')
    expect(merchant['data']['attributes']['name']).to be_a String
  end

  it 'can create a new merchant' do
    merchant_params = {
      name: 'Sunshine Books',
      created_at: '12/12/20',
      updated_at: '12/13/20'
    }
    post '/api/v1/merchants', params: merchant_params

    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(response.status).to_not eq(404)

    created_merchant = Merchant.last
    expect(created_merchant).to be_a Merchant

    expect(created_merchant.name).to eq(merchant_params[:name])
  end

  it 'can not create a new merchant without merchant_params' do
    post '/api/v1/merchants'

    expect(response.status).to_not eq(200)
    expect(response.status).to eq(404)
  end

  it 'cannot create new merchant when only some merchant_params are present' do
    merchant_params = {
      name: '',
      created_at: '12/12/20',
      updated_at: '12/13/20'
    }
    post '/api/v1/merchants', params: merchant_params

    expect(response.status).to_not eq(200)
    expect(response.status).to eq(404)
  end

  it 'can update attributes of a merchant' do
    merchant_name = create(:merchant)
    merchant_params = { name: 'Sir Francis Drake',
                        created_at: '12/11/20',
                        updated_at: '12/12/20' }

    patch "/api/v1/merchants/#{merchant_name.id}", params: merchant_params

    expect(response).to be_successful
    result = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(result[:id].to_i).to eq(merchant_name.id)
    expect(result[:attributes][:name]).to eq(merchant_params[:name])
    expect(result[:attributes][:name]).to_not eq(merchant_name[:name])

    merchant = Merchant.find_by(id: merchant_name.id)
    expect(merchant.name).to_not eq(merchant_name)
    expect(merchant.name).to eq(merchant_params[:name])
  end

  it 'cannot update attributes of a merchant if its empty' do
    id = create(:merchant).id

    merchant_params = { name: '',
                        created_at: '12/11/20',
                        updated_at: '12/12/20' }

    patch "/api/v1/merchants/#{id}", params: merchant_params

    expect(response).to_not be_successful
    expect(response.status).to eq(404)
  end

  it 'can destroy a merchant object' do
    id = create(:merchant).id

    delete "/api/v1/merchants/#{id}"
    expect(response.body).to eq('')
    expect(response.status).to eq(204)
    expect(response.status).to_not eq(404)
  end

  it 'cannot destroy a merchant object without an id' do
    merchant = create(:merchant, id: 2)
    delete "/api/v1/merchants/1"
    expect(response).to_not be_successful
    expect(response.status).to eq(404)
  end
end
