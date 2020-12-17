require 'rails_helper'

RSpec.describe 'Items API' do
  it 'can send a list of items' do
    create_list(:item, 4)

    get '/api/v1/items'

    expect(response).to be_successful
    items = JSON.parse(response.body, symbolize: true)

    expect(items['data'].count).to eq(4)

    items['data'].each do |item|
      expect(item).to have_key('id')
      expect(item['id']).to be_a String

      expect(item).to have_key('type')
      expect(item['type']).to eq('item')

      expect(item['attributes']).to have_key('name')
      expect(item['attributes']['name']).to be_a String

      expect(item['attributes']).to have_key('description')
      expect(item['attributes']['description']).to be_a String

      expect(item['attributes']).to have_key('unit_price')
      expect(item['attributes']['unit_price']).to be_a Float

      expect(item['attributes']).to have_key('created_at')
      expect(item['attributes']['created_at']).to be_a String

      expect(item['attributes']).to have_key('updated_at')
      expect(item['attributes']['updated_at']).to be_a String
    end
  end

  it 'can send a unique item information' do
    id = create(:item).id

    get "/api/v1/items/#{id}"

    item = JSON.parse(response.body, symbolize: true)

    expect(response).to be_successful
    expect(item).to be_a Hash

    expect(item['data']).to have_key('id')
    expect(item['data']['id']).to be_a String

    expect(item['data']).to have_key('type')
    expect(item['data']['type']).to eq('item')

    expect(item['data']['attributes']).to have_key('name')
    expect(item['data']['attributes']['name']).to be_a String

    expect(item['data']['attributes']).to have_key('description')
    expect(item['data']['attributes']['description']).to be_a String

    expect(item['data']['attributes']).to have_key('unit_price')
    expect(item['data']['attributes']['unit_price']).to be_a Float

    expect(item['data']['attributes']).to have_key('created_at')
    expect(item['data']['attributes']['created_at']).to be_a String

    expect(item['data']['attributes']).to have_key('updated_at')
    expect(item['data']['attributes']['updated_at']).to be_a String
  end

  it 'can create a new item' do
    merchant_id = create(:merchant).id
    item_params = {
      name: 'The Boy, the Mole, the Fox and the Horse',
      description: 'Charlie Mackesy offers inspiration and hope in uncertain times in this beautiful book, following the tale of a curious boy, a greedy mole, a wary fox and a wise horse who find themselves together in sometimes difficult terrain, sharing their greatest fears and biggest discoveries about vulnerability, kindness, hope, friendship and love.
      The shared adventures and important conversations between the four friends are full of life lessons that have connected with readers of all ages. ',
      unit_price: 14.13,
      merchant_id: merchant_id,
      created_at: '12/12/20',
      updated_at: '12/13/20'
    }
    post '/api/v1/items', params: item_params

    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(response.status).to_not eq(404)

    created_item = Item.last
    expect(created_item).to be_a Item

    expect(created_item.name).to eq(item_params[:name])
    expect(created_item.description).to eq(item_params[:description])
    expect(created_item.unit_price).to eq(item_params[:unit_price])
  end

  it 'can not create a new item without item_params' do
    post '/api/v1/items'

    expect(response.status).to_not eq(200)
    expect(response.status).to eq(404)
  end

  it 'can not create a new item when only some item_params are present' do
    item_params = {
      name: '',
      created_at: '12/12/20',
      updated_at: '12/13/20'
    }
    post '/api/v1/items', params: item_params

    expect(response.status).to_not eq(200)
    expect(response.status).to eq(404)
  end

  it 'can update attributes of a item' do
    merchant = create(:merchant)
    item_name = create(:item,)
    item_params = {
      name: 'The Boy, the Mole, the Fox and the Horse',
      description: item_name[:description],
      unit_price: item_name[:unit_price],
      merchant_id: merchant.id,
      created_at: item_name[:created_at],
      updated_at: item_name[:updated_at]
    }
    patch "/api/v1/items/#{item_name.id}", params: item_params

    expect(response).to be_successful
    result = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(result[:id].to_i).to eq(item_name.id)
    expect(result[:attributes][:name]).to eq(item_params[:name])
    expect(result[:attributes][:description]).to eq(item_name[:description])
    item = Item.find_by(id: item_name.id)
    expect(item.name).to_not eq(item_name)
    expect(item.name).to eq(item_params[:name])
  end

  it 'cannot update attributes of a item if its empty' do
    id = create(:item).id
    original_item_name = Item.last.name

    item_params = { name: '',
                    created_at: '12/11/20',
                    updated_at: '12/12/20' }

    patch "/api/v1/items/#{id}", params: item_params

    expect(response).to_not be_successful
    expect(response.status).to eq(404)
  end

  it 'can destroy a item object' do
    id = create(:item).id

    delete "/api/v1/items/#{id}"
    expect(response.body).to eq('')
    expect(response.status).to eq(204)
    expect(response.status).to_not eq(400)
  end

  it 'cannot destroy a item object without an id' do
    item = create(:item, id: 2)
    delete '/api/v1/items/1'
    expect(response).to_not be_successful
    expect(response.status).to eq(404)
  end
end
