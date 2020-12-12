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
end
