require 'rails_helper'

RSpec.describe 'Finds the Merchant with the most items' do
  scenario 'returns x number top merchants with the most items sold' do
    merchant1 = create(:merchant, name: 'Richard')
    merchant2 = create(:merchant, name: 'Haley')
    merchant3 = create(:merchant, name: 'August')
    merchant4 = create(:merchant, name: 'Lorelei')
    merchant5 = create(:merchant, name: 'Matt')

    invoice1 = create(:invoice, merchant_id: merchant1.id, status: 'shipped')
    create(:transaction, result: 'success', invoice_id: invoice1.id)
    create(:invoice_item,
          quantity: 12,
          unit_price: 101.00,
          invoice_id: invoice1.id,
          item_id: create(:item, unit_price: 10.00).id)

    invoice2 = create(:invoice, merchant_id: merchant1.id, status: 'shipped')
    create(:transaction, result: 'failed', invoice_id: invoice2.id)
    create(:invoice_item,
          quantity: 5,
          unit_price: 10.00,
          invoice_id: invoice2.id,
          item_id: create(:item, unit_price: 10.00).id)

    invoice3 = create(:invoice, merchant_id: merchant2.id, status: 'shipped')
    create(:transaction, result: 'success', invoice_id: invoice3.id)
    create(:invoice_item,
          quantity: 6,
          unit_price: 2_103.00,
          invoice_id: invoice3.id,
          item_id: create(:item, unit_price: 20.00).id)

    invoice4 = create(:invoice, merchant_id: merchant2.id, status: 'shipped')
    create(:transaction, result: 'failed', invoice_id: invoice4.id)
    create(:invoice_item,
          quantity: 11,
          unit_price: 20.00,
          invoice_id: invoice4.id,
          item_id: create(:item, unit_price: 20.00).id)

    invoice5 = create(:invoice, merchant_id: merchant1.id, status: 'shipped')
    create(:transaction, result: 'success', invoice_id: invoice5.id)
    create(:invoice_item,
          quantity: 2,
          unit_price: 345.00,
          invoice_id: invoice5.id,
          item_id: create(:item, unit_price: 30.00).id)

    invoice6 = create(:invoice, merchant_id: merchant3.id, status: 'shipped')
    create(:transaction, result: 'failed', invoice_id: invoice6.id)
    create(:invoice_item,
          quantity: 7,
          unit_price: 375.00,
          invoice_id: invoice6.id,
          item_id: create(:item, unit_price: 30.00).id)

    invoice7 = create(:invoice, merchant_id: merchant2.id, status: 'packaged')
    create(:transaction, result: 'success', invoice_id: invoice7.id)
    create(:invoice_item,
          quantity: 1,
          unit_price: 430.34,
          invoice_id: invoice7.id,
          item_id: create(:item, unit_price: 40.00).id)

    invoice8 = create(:invoice, merchant_id: merchant4.id, status: 'shipped')
    create(:transaction, result: 'failed', invoice_id: invoice8.id)
    create(:invoice_item,
          quantity: 1,
          unit_price: 40.00,
          invoice_id: invoice8.id,
          item_id: create(:item, unit_price: 40.00).id)

    invoice9 = create(:invoice, merchant_id: merchant1.id, status: 'shipped')
    create(:transaction, result: 'success', invoice_id: invoice9.id)
    create(:invoice_item,
          quantity: 1,
          unit_price: 500.00,
          invoice_id: invoice9.id,
          item_id: create(:item, unit_price: 50.00).id)

    invoice10 = create(:invoice, merchant_id: merchant5.id, status: 'shipped')
    create(:transaction, result: 'failed', invoice_id: invoice10.id)
    create(:invoice_item,
          quantity: 1,
          unit_price: 50.00,
          invoice_id: invoice10.id,
          item_id: create(:item, unit_price: 50.00).id)

    invoice11 = create(:invoice, merchant_id: merchant5.id, status: 'shipped')
    create(:transaction, result: 'success', invoice_id: invoice11.id)
    create(:invoice_item,
          quantity: 4,
          unit_price: 500.00,
          invoice_id: invoice11.id,
          item_id: create(:item, unit_price: 50.00).id)

    quantity = 3
    get "/api/v1/merchants/most_items?quantity=#{quantity}"
    results = JSON.parse(response.body, symbolize_names: true)[:data]
    # total_items_merchant1 = 15
    # total_items_merchant2 = 6
    # total_items_merchant5 = 4
    expect(results.count).to eq(quantity)
    expect(results[0][:attributes][:name]).to eq(merchant1[:name])
    expect(results[0][:id].to_i).to eq(merchant1[:id])
    expect(results[1][:attributes][:name]).to eq(merchant2[:name])
    expect(results[1][:id].to_i).to eq(merchant2[:id])
    results.each do |result|
      expect(result[:id].to_i).to eq(merchant1.id)
                              .or(eq merchant2.id)
                              .or(eq merchant5.id)
      expect(result[:id].to_i).to_not eq(merchant3.id)
      expect(result[:id].to_i).to_not eq(merchant4.id)
      expect(result[:attributes][:name]).to eq(merchant1.name)
                                        .or(eq merchant2.name)
                                        .or(eq merchant5.name)
    end
  end
end
