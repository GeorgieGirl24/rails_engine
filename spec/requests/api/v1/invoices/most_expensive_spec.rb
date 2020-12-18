require 'rails_helper'

RSpec.describe 'Finds the Invoices with the most expensive revenues' do
  scenario 'returns x number top Invoices with the most expensive totals' do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)

    invoice1 = create(:invoice, merchant_id: merchant1.id, status: 'shipped')
    create(:transaction, result: 'success', invoice_id: invoice1.id)
    create(:invoice_item,
          quantity: 5,
          unit_price: 100.00,
          invoice_id: invoice1.id,
          item_id: create(:item, unit_price: 10.00).id)
    # invoice1_total = 500

    invoice2 = create(:invoice, merchant_id: merchant1.id, status: 'shipped')
    create(:transaction, result: 'success', invoice_id: invoice2.id)
    create(:invoice_item,
          quantity: 7,
          unit_price: 1_000.00,
          invoice_id: invoice2.id,
          item_id: create(:item, unit_price: 10.00).id)
    # invoice2_total = 7_000

    invoice3 = create(:invoice, merchant_id: merchant2.id, status: 'shipped')
    create(:transaction, result: 'success', invoice_id: invoice3.id)
    create(:invoice_item,
          quantity: 1,
          unit_price: 300.00,
          invoice_id: invoice3.id,
          item_id: create(:item, unit_price: 10.00).id)
    # invoice3_total = 300

    invoice4 = create(:invoice, merchant_id: merchant2.id, status: 'shipped')
    create(:transaction, result: 'failed', invoice_id: invoice4.id)
    create(:invoice_item,
          quantity: 1,
          unit_price: 150.00,
          invoice_id: invoice4.id,
          item_id: create(:item, unit_price: 10.00).id)
    # invoice4_total = nil

    invoice5 = create(:invoice, merchant_id: merchant2.id, status: 'shipped')
    create(:transaction, result: 'success', invoice_id: invoice5.id)
    create(:invoice_item,
          quantity: 6,
          unit_price: 2_000.00,
          invoice_id: invoice5.id,
          item_id: create(:item, unit_price: 10.00).id)
    # invoice5_total = 12_000

    invoice6 = create(:invoice, merchant_id: merchant2.id, status: 'packaged')
    create(:transaction, result: 'success', invoice_id: invoice6.id)
    create(:invoice_item,
          quantity: 2,
          unit_price: 10_000.50,
          invoice_id: invoice6.id,
          item_id: create(:item, unit_price: 10.00).id)
    # invoice6_total = nil

    invoice7 = create(:invoice, merchant_id: merchant1.id, status: 'shipped')
    create(:transaction, result: 'failed', invoice_id: invoice7.id)
    create(:invoice_item,
          quantity: 1,
          unit_price: 7_500.00,
          invoice_id: invoice7.id,
          item_id: create(:item, unit_price: 10.00).id)
    # invoice7_total = 7_500

    invoice8 = create(:invoice, merchant_id: merchant1.id, status: 'shipped')
    create(:transaction, result: 'success', invoice_id: invoice8.id)
    create(:invoice_item,
          quantity: 100,
          unit_price: 10.00,
          invoice_id: invoice8.id,
          item_id: create(:item, unit_price: 10.00).id)
    # invoice8_total = 1_000

    invoice9 = create(:invoice, merchant_id: merchant1.id, status: 'shipped')
    create(:transaction, result: 'success', invoice_id: invoice9.id)
    create(:invoice_item,
          quantity: 105,
          unit_price: 10.00,
          invoice_id: invoice9.id,
          item_id: create(:item, unit_price: 10.00).id)
    # invoice9_total = 1_050

    invoice10 = create(:invoice, merchant_id: merchant1.id, status: 'shipped')
    create(:transaction, result: 'success', invoice_id: invoice10.id)
    create(:invoice_item,
          quantity: 100,
          unit_price: 9.00,
          invoice_id: invoice10.id,
          item_id: create(:item, unit_price: 10.00).id)
    # invoice10_total = 900

    invoice11 = create(:invoice, merchant_id: merchant1.id, status: 'shipped')
    create(:transaction, result: 'success', invoice_id: invoice11.id)
    create(:invoice_item,
          quantity: 100,
          unit_price: 100.00,
          invoice_id: invoice11.id,
          item_id: create(:item, unit_price: 10.00).id)
    # invoice11_total = 10_000

    quantity = 5
    get "/api/v1/invoices/most_expensive?quantity=#{quantity}"

    results = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(response).to be_successful

    expect(results.count).to eq(quantity)
    expect(results[0]).to have_key :id
    expect(results[0][:id].to_i).to eq(invoice5.id)
    expect(results[0]).to have_key :type
    expect(results[0][:type]).to eq('invoice')
    expect(results[0][:attributes]).to have_key :id
    expect(results[0][:attributes][:id]).to eq(invoice5.id)
    expect(results[0][:attributes]).to have_key :status
    expect(results[0][:attributes][:status]).to eq('shipped')
    expect(results[0][:attributes]).to have_key :merchant_id
    expect(results[0][:attributes][:merchant_id]).to eq(invoice5[:merchant_id])
    expect(results[0][:attributes]).to have_key :customer_id
    expect(results[0][:attributes][:customer_id]).to eq(invoice5[:customer_id])
    results.each do |result|
      expect(result[:id].to_i).to_not eq(invoice4.id)
      expect(result[:id].to_i).to_not eq(invoice1.id)
      expect(result[:id].to_i).to_not eq(invoice6.id)
      expect(result[:id].to_i).to_not eq(invoice7.id)
      expect(result[:id].to_i).to_not eq(invoice3.id)
      expect(result[:id].to_i).to_not eq(invoice10.id)
    end
  end
end
