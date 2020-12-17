require 'rails_helper'

describe Invoice do
  describe 'relationships' do
    it { should belong_to :customer }
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many :transactions }
    it { should have_many(:items).through(:invoice_items) }
  end

  describe 'validations' do
    it { should validate_presence_of :status }
  end

  describe 'class methods' do
    it '.most_expensive' do
      merchant1 = create(:merchant)
      merchant2 = create(:merchant)

      invoice1 = create(:invoice, merchant_id: merchant1.id)
      create(:transaction, result: 'success', invoice_id: invoice1.id)
      create(:invoice_item, quantity: 1, unit_price: 100.00, invoice_id: invoice1.id, item_id: create(:item, unit_price: 10.00).id)

      invoice2 = create(:invoice, merchant_id: merchant1.id)
      create(:transaction, result: 'success', invoice_id: invoice2.id)
      create(:invoice_item, quantity: 1, unit_price: 1_000.00, invoice_id: invoice2.id, item_id: create(:item, unit_price: 10.00).id)

      invoice3 = create(:invoice, merchant_id: merchant2.id)
      create(:transaction, result: 'success', invoice_id: invoice3.id)
      create(:invoice_item, quantity: 1, unit_price: 300.00, invoice_id: invoice3.id, item_id: create(:item, unit_price: 10.00).id)

      invoice4 = create(:invoice, merchant_id: merchant2.id)
      create(:transaction, result: 'failed', invoice_id: invoice4.id)
      create(:invoice_item, quantity: 1, unit_price: 150.00, invoice_id: invoice4.id, item_id: create(:item, unit_price: 10.00).id)

      invoice5 = create(:invoice, merchant_id: merchant2.id)
      create(:transaction, result: 'success', invoice_id: invoice5.id)
      create(:invoice_item, quantity: 1, unit_price: 2_000.00, invoice_id: invoice5.id, item_id: create(:item, unit_price: 10.00).id)

      invoice6 = create(:invoice, merchant_id: merchant2.id)
      create(:transaction, result: 'success', invoice_id: invoice6.id)
      create(:invoice_item, quantity: 1, unit_price: 10_000.50, invoice_id: invoice6.id, item_id: create(:item, unit_price: 10.00).id)

      invoice7 = create(:invoice, merchant_id: merchant1.id)
      create(:transaction, result: 'failed', invoice_id: invoice7.id)
      create(:invoice_item, quantity: 1, unit_price: 7_000.00, invoice_id: invoice7.id, item_id: create(:item, unit_price: 10.00).id)

      invoice8 = create(:invoice, merchant_id: merchant1.id)
      create(:transaction, result: 'success', invoice_id: invoice8.id)
      create(:invoice_item, quantity: 1, unit_price: 10.00, invoice_id: invoice8.id, item_id: create(:item, unit_price: 10.00).id)

      quantity = 5
      results = Invoice.most_expensive(quantity)

      expect(results.first).to be_a Invoice
      expect(results.first[:id]).to be_a Integer
      expect(results.first[:customer_id]).to be_a Integer
      expect(results.first[:merchant_id]).to be_a Integer

      expect(results.first[:id]).to eq(invoice6.id)
      expect(results.fifth[:id]).to eq(invoice1.id)
    end
  end
end
