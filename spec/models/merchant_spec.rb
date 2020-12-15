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
      merchant_1 = create(:merchant, name: 'The Happily Ever Crafter')
      merchant_2 = create(:merchant)
      merchant_3 = create(:merchant)
      # search = 'The Happily Ever Crafter'
      # attribute = :name
      response = Merchant.search_single({name: 'The Happily Ever Crafter'}).first
      expect(response).to be_a Merchant
      expect(response[:name]).to be_a String
    end

    it '.search_date' do
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant, created_at: '2020-12-14')
      merchant_3 = create(:merchant)
      # search = '2020-14-12'
      # attribute = :created_at
      response = Merchant.search_date({created_at: '2020-12-14'}).first
      expect(response).to be_a Merchant
      expect(response[:name]).to be_a String
    end
  end
end
