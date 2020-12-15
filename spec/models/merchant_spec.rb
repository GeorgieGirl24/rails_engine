require 'rails_helper'

describe Merchant do
  describe 'relationships' do
    it { should have_many :items }
    it { should have_many :invoices }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe 'class methods' do
    it '.search_single' do
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant, created_at: '2020-12-14')
      merchant_3 = create(:merchant, name: 'Her Name Is Mud')
      search = '2020-12-14'
      attribute = 'created_at'
      response = Merchant.search_single(attribute, search)
      expect(response).to be_a Merchant
      expect(response[:name]).to be_a String

      search_1 = 'Her Name Is Mud'
      attribute_1 = 'name'
      response_1 = Merchant.search_single(attribute_1, search_1)
      expect(response_1).to be_a Merchant
      expect(response_1[:name]).to be_a String
    end

    it '.search_date' do
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant, created_at: '2020-12-14')
      merchant_3 = create(:merchant)
      search = '2020-12-14'
      attribute = 'created_at'
      response = Merchant.search_date(attribute, search)
      # expect(response).to be_a Array
      expect(response.first).to be_a Merchant
      expect(response.first[:name]).to be_a String
    end

    it '.search_string' do
      merchant_1 = create(:merchant, name: 'The Happily Ever Crafter')
      merchant_2 = create(:merchant)
      merchant_3 = create(:merchant)
      search = 'The Happily Ever Crafter'
      attribute = 'name'
      response = Merchant.search_string(attribute, search)
      # expect(response).to be_a Array
      expect(response.first).to be_a Merchant
      expect(response.first[:name]).to be_a String
    end

    it '.search_multiple' do
      merchant_1 = create(:merchant, name: 'The Happily Ever Crafter')
      merchant_2 = create(:merchant, name: 'Crafting Made Easy')
      merchant_3 = create(:merchant)
      search = 'Craft'
      attribute = 'name'
      response = Merchant.search_multiple(attribute, search)
      # expect(response).to be_a Array
      expect(response.count).to eq(2)
      expect(response.first).to be_a Merchant
      expect(response.first[:name]).to be_a String
    end
  end
end
