require 'rails_helper'

RSpec.describe 'Finds the Merchant with the most items' do
  scenario 'returns x number top merchants with the most items sold' do
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
    get "/api/v1/merchants/most_items?quantity=#{quantity}"
    results = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(results.count).to eq(quantity)

    results.each do |result|
      expect(result[:id].to_i).to eq(merchant1.id).or(eq merchant2.id)
      expect(result[:id].to_i).to_not eq(merchant3.id)
      expect(result[:id].to_i).to_not eq(merchant4.id)
      expect(result[:id].to_i).to_not eq(merchant5.id)
      expect(result[:attributes][:name]).to eq(merchant1.name).or(eq merchant2.name)
    end
  end
end
