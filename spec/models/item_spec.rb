require 'rails_helper'

describe Item do
  describe 'relationships' do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
  end

  describe 'class methods' do
    it '.search_single' do
      item1 = create(:item, name: 'ZZ Plant')
      item2 = create(:item, description: 'Green and strong!')
      item3 = create(:item, unit_price: 10.87)
      item4 = create(:item, created_at: '2020-12-12')

      search = 'ZZ Plant'
      attribute = :name
      response = Item.search_single(attribute, search)
      expect(response).to be_a Item
      expect(response[:name]).to be_a String
      expect(response[:description]).to be_a String
      expect(response[:unit_price]).to be_a Float

      search_1 = 'Green'
      attribute_1 = :description
      response = Item.search_single(attribute_1, search_1)
      expect(response).to be_a Item
      expect(response[:name]).to be_a String
      expect(response[:description]).to be_a String
      expect(response[:unit_price]).to be_a Float

      search_2 = 10.87
      attribute_2 = 'unit_price'
      response = Item.search_single(attribute_2, search_2)
      expect(response).to be_a Item
      expect(response[:name]).to be_a String
      expect(response[:description]).to be_a String
      expect(response[:unit_price]).to be_a Float

      search_3 = '2020-12-12'
      attribute_3 = 'created_at'
      response = Item.search_single(attribute_3, search_3)
      expect(response).to be_a Item
      expect(response[:name]).to be_a String
      expect(response[:description]).to be_a String
      expect(response[:unit_price]).to be_a Float
    end

    it '.search_string' do
      item1 = create(:item, name: 'ZZ Plant')
      item2 = create(:item)
      item3 = create(:item)
      search = 'ZZ Plant'
      attribute = :name
      response = Item.search_string(attribute, search).first
      expect(response).to be_a Item
      expect(response[:name]).to be_a String
      expect(response[:description]).to be_a String
      expect(response[:unit_price]).to be_a Float
    end

    it '.search_date' do
      item1 = create(:item)
      item2 = create(:item, created_at: '2020-12-14')
      item3 = create(:item)
      search = '2020-12-14'
      attribute = :created_at
      response = Item.search_date(attribute, search).first
      expect(response).to be_a Item
      expect(response[:name]).to be_a String
      expect(response[:description]).to be_a String
      expect(response[:unit_price]).to be_a Float
    end

    it '.unit_price_search' do
      item1 = create(:item)
      item2 = create(:item)
      item3 = create(:item, unit_price: 13.95)
      search = 13.95
      attribute = :unit_price
      response = Item.unit_price_search(attribute, search).first
      expect(response).to be_a Item
      expect(response[:name]).to be_a String
      expect(response[:description]).to be_a String
      expect(response[:unit_price]).to be_a Float
    end

    it '.search_multiple' do
      item1 = create(:item, updated_at: '2020-04-01T00:00:00 UTC')
      item2 = create(:item, updated_at: '2020-04-01T00:00:00 UTC')
      item3 = create(:item, unit_price: 13.95)
      item4 = create(:item, unit_price: 13.95)
      item4 = create(:item, name: 'Zz Plant')
      item4 = create(:item, name: 'Prayer Plant')

      search = 13.95
      attribute = 'unit_price'
      response = Item.search_multiple(attribute, search)
      expect(response.count).to eq(2)
      expect(response.first).to be_a Item
      expect(response.first[:name]).to be_a String

      search1 = '2020-04-01T00:00:00 UTC'
      attribute1 = 'updated_at'
      response1 = Item.search_multiple(attribute1, search1)
      expect(response1.count).to eq(2)
      expect(response1.first).to be_a Item
      expect(response1.first[:name]).to be_a String

      search2 = 'PLANT'
      attribute2 = 'name'
      response2 = Item.search_multiple(attribute2, search2)
      expect(response2.count).to eq(2)
      expect(response2.first).to be_a Item
      expect(response2.first[:name]).to be_a String
    end
  end
end
