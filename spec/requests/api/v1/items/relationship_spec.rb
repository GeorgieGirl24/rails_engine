require 'rails_helper'

RSpec.describe 'Items relationship with all its merchant' do
  it 'can return all the associated merchant of a Item' do
    item1 = create(:item)
    item2 = create(:item)
    id = item1.id
    get "/api/v1/items/#{id}/merchants"

    expect(response).to be_successful
    item = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(Item.all.count).to eq(2)

    expect(item).to have_key :id
    expect(item[:id]).to be_a String

    expect(item).to have_key :type
    expect(item[:type]).to eq 'merchant'

    expect(item[:attributes]).to have_key :name
    expect(item[:attributes][:name]).to be_a String

    expect(item[:attributes]).to have_key :created_at
    expect(item[:attributes][:created_at]).to be_a String

    expect(item[:attributes]).to have_key :updated_at
    expect(item[:attributes][:updated_at]).to be_a String
  end
end
