require 'rails_helper'

describe Item do
  describe 'relationships' do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items)}
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
  end

  describe 'class methods' do
    it '.search_single' do
      item_1 = create(:item, name: 'ZZ Plant')
      item_2 = create(:item)
      item_3 = create(:item)
      # search = 'ZZ Plant'
      # attribute = :name
      response = Item.search_single({name: 'ZZ Plant'}).first
      expect(response).to be_a Item
      expect(response[:name]).to be_a String
      expect(response[:description]).to be_a String
      expect(response[:unit_price]).to be_a Float
    end

    it '.search_date' do
      item_1 = create(:item)
      item_2 = create(:item, created_at: '2020-12-14')
      item_3 = create(:item)
      # search = '2020-14-12'
      # attribute = :created_at
      response = Item.search_date({created_at: '2020-12-14'}).first
      expect(response).to be_a Item
      expect(response[:name]).to be_a String
      expect(response[:description]).to be_a String
      expect(response[:unit_price]).to be_a Float
    end

    it '.unit_price_search' do
      item_1 = create(:item)
      item_2 = create(:item)
      item_3 = create(:item, unit_price: 13.95)
      # search = 13.95
      # attribute = :unit_price
      response = Item.unit_price_search({unit_price: 13.95}).first
      expect(response).to be_a Item
      expect(response[:name]).to be_a String
      expect(response[:description]).to be_a String
      expect(response[:unit_price]).to be_a Float
    end
  end
end
