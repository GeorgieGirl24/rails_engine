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
      merchant1 = create(:merchant)
      merchant2 = create(:merchant, created_at: '2020-12-14')
      merchant3 = create(:merchant, name: 'Her Name Is Mud')
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
      merchant1 = create(:merchant)
      merchant2 = create(:merchant, created_at: '2020-12-14')
      merchant3 = create(:merchant)
      search = '2020-12-14'
      attribute = 'created_at'
      response = Merchant.search_date(attribute, search)
      # expect(response).to be_a Array
      expect(response.first).to be_a Merchant
      expect(response.first[:name]).to be_a String
    end

    it '.search_string' do
      merchant1 = create(:merchant, name: 'The Happily Ever Crafter')
      merchant2 = create(:merchant)
      merchant3 = create(:merchant)
      search = 'The Happily Ever Crafter'
      attribute = 'name'
      response = Merchant.search_string(attribute, search)
      # expect(response).to be_a Array
      expect(response.first).to be_a Merchant
      expect(response.first[:name]).to be_a String
    end

    it '.search_multiple' do
      merchant1 = create(:merchant, name: 'The Happily Ever Crafter')
      merchant2 = create(:merchant, name: 'Crafting Made Easy')
      merchant3 = create(:merchant)
      search = 'Craft'
      attribute = 'name'
      response = Merchant.search_multiple(attribute, search)
      # expect(response).to be_a Array
      expect(response.count).to eq(2)
      expect(response.first).to be_a Merchant
      expect(response.first[:name]).to be_a String
    end

    it '.most_revenue' do
      merchant1 = create(:merchant)
      merchant2 = create(:merchant)
      merchant3 = create(:merchant)
      merchant4 = create(:merchant)
      merchant5 = create(:merchant)

      invoice1 = create(:invoice, merchant_id: merchant1.id)
      create(:transaction, result: 'success', invoice_id: invoice1.id)
      create(:invoice_item, quantity: 1, unit_price: 10.00, invoice_id: invoice1.id, item_id: create(:item, unit_price: 10.00).id)

      invoice2 = create(:invoice, merchant_id: merchant1.id)
      create(:transaction, result: 'failed', invoice_id: invoice2.id)
      create(:invoice_item, quantity: 1, unit_price: 10.00, invoice_id: invoice2.id, item_id: create(:item, unit_price: 10.00).id)

      invoice3 = create(:invoice, merchant_id: merchant2.id)
      create(:transaction, result: 'success', invoice_id: invoice3.id)
      create(:invoice_item, quantity: 1, unit_price: 20.00, invoice_id: invoice3.id, item_id: create(:item, unit_price: 20.00).id)

      invoice4 = create(:invoice, merchant_id: merchant2.id)
      create(:transaction, result: 'failed', invoice_id: invoice4.id)
      create(:invoice_item, quantity: 1, unit_price: 20.00, invoice_id: invoice4.id, item_id: create(:item, unit_price: 20.00).id)

      invoice5 = create(:invoice, merchant_id: merchant3.id)
      create(:transaction, result: 'success', invoice_id: invoice5.id)
      create(:invoice_item, quantity: 1, unit_price: 30.00, invoice_id: invoice5.id, item_id: create(:item, unit_price: 30.00).id)

      invoice6 = create(:invoice, merchant_id: merchant3.id)
      create(:transaction, result: 'failed', invoice_id: invoice6.id)
      create(:invoice_item, quantity: 1, unit_price: 30.00, invoice_id: invoice6.id, item_id: create(:item, unit_price: 30.00).id)

      invoice7 = create(:invoice, merchant_id: merchant4.id)
      create(:transaction, result: 'success', invoice_id: invoice7.id)
      create(:invoice_item, quantity: 1, unit_price: 40.00, invoice_id: invoice7.id, item_id: create(:item, unit_price: 40.00).id)

      invoice8 = create(:invoice, merchant_id: merchant4.id)
      create(:transaction, result: 'failed', invoice_id: invoice8.id)
      create(:invoice_item, quantity: 1, unit_price: 40.00, invoice_id: invoice8.id, item_id: create(:item, unit_price: 40.00).id)

      invoice9 = create(:invoice, merchant_id: merchant5.id)
      create(:transaction, result: 'success', invoice_id: invoice9.id)
      create(:invoice_item, quantity: 1, unit_price: 50.00, invoice_id: invoice9.id, item_id: create(:item, unit_price: 50.00).id)

      invoice10 = create(:invoice, merchant_id: merchant5.id)
      create(:transaction, result: 'failed', invoice_id: invoice10.id)
      create(:invoice_item, quantity: 1, unit_price: 50.00, invoice_id: invoice10.id, item_id: create(:item, unit_price: 50.00).id)

      quantity = 3
      response = Merchant.most_revenue(quantity)

      expect(response.first).to be_a Merchant
      expect(response.first[:name]).to eq(merchant5.name)
      expect(response.second[:name]).to eq(merchant4.name)
      expect(response.third[:name]).to eq(merchant3.name)
    end
  end

  it '.most_items' do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    merchant3 = create(:merchant)
    merchant4 = create(:merchant)
    merchant5 = create(:merchant)

    invoice1 = create(:invoice, merchant_id: merchant1.id)
    create(:transaction, result: 'success', invoice_id: invoice1.id)
    create(:invoice_item, quantity: 1, unit_price: 10.00, invoice_id: invoice1.id, item_id: create(:item, unit_price: 10.00).id)

    invoice2 = create(:invoice, merchant_id: merchant1.id)
    create(:transaction, result: 'failed', invoice_id: invoice2.id)
    create(:invoice_item, quantity: 1, unit_price: 10.00, invoice_id: invoice2.id, item_id: create(:item, unit_price: 10.00).id)

    invoice3 = create(:invoice, merchant_id: merchant2.id)
    create(:transaction, result: 'success', invoice_id: invoice3.id)
    create(:invoice_item, quantity: 1, unit_price: 20.00, invoice_id: invoice3.id, item_id: create(:item, unit_price: 20.00).id)

    invoice4 = create(:invoice, merchant_id: merchant2.id)
    create(:transaction, result: 'failed', invoice_id: invoice4.id)
    create(:invoice_item, quantity: 1, unit_price: 20.00, invoice_id: invoice4.id, item_id: create(:item, unit_price: 20.00).id)

    invoice5 = create(:invoice, merchant_id: merchant1.id)
    create(:transaction, result: 'success', invoice_id: invoice5.id)
    create(:invoice_item, quantity: 1, unit_price: 30.00, invoice_id: invoice5.id, item_id: create(:item, unit_price: 30.00).id)

    invoice6 = create(:invoice, merchant_id: merchant3.id)
    create(:transaction, result: 'failed', invoice_id: invoice6.id)
    create(:invoice_item, quantity: 1, unit_price: 30.00, invoice_id: invoice6.id, item_id: create(:item, unit_price: 30.00).id)

    invoice7 = create(:invoice, merchant_id: merchant2.id)
    create(:transaction, result: 'success', invoice_id: invoice7.id)
    create(:invoice_item, quantity: 1, unit_price: 40.00, invoice_id: invoice7.id, item_id: create(:item, unit_price: 40.00).id)

    invoice8 = create(:invoice, merchant_id: merchant4.id)
    create(:transaction, result: 'failed', invoice_id: invoice8.id)
    create(:invoice_item, quantity: 1, unit_price: 40.00, invoice_id: invoice8.id, item_id: create(:item, unit_price: 40.00).id)

    invoice9 = create(:invoice, merchant_id: merchant1.id)
    create(:transaction, result: 'success', invoice_id: invoice9.id)
    create(:invoice_item, quantity: 1, unit_price: 50.00, invoice_id: invoice9.id, item_id: create(:item, unit_price: 50.00).id)

    invoice10 = create(:invoice, merchant_id: merchant5.id)
    create(:transaction, result: 'failed', invoice_id: invoice10.id)
    create(:invoice_item, quantity: 1, unit_price: 50.00, invoice_id: invoice10.id, item_id: create(:item, unit_price: 50.00).id)

    quantity = 2
    results = Merchant.most_items(quantity)
    expect(results.first).to be_a Merchant

    results.each do |result|
      expect(result[:id].to_i).to eq(merchant1.id).or(eq merchant2.id)
      expect(result[:id].to_i).to_not eq(merchant3.id)
      expect(result[:id].to_i).to_not eq(merchant4.id)
      expect(result[:id].to_i).to_not eq(merchant5.id)
      expect(result[:name]).to eq(merchant1.name).or(eq merchant2.name)
    end
  end
end
