require 'rails_helper'

RSpec.describe 'Revenue Across Date Range' do
  scenario 'Returns total revenue across all merchants in a given date range' do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    merchant3 = create(:merchant)
    merchant4 = create(:merchant)
    merchant5 = create(:merchant)

    invoice1 = create(:invoice, merchant_id: merchant1.id, status: 'shipped', created_at: '2020-01-01T00:00:00 UTC')
    create(:transaction, result: 'success', invoice_id: invoice1.id)
    create(:invoice_item, quantity: 1, unit_price: 10.00, invoice_id: invoice1.id, item_id: create(:item, unit_price: 10.00).id)

    invoice2 = create(:invoice, merchant_id: merchant1.id, status: 'shipped', created_at: '2020-02-01T00:00:00 UTC')
    create(:transaction, result: 'failed', invoice_id: invoice2.id)
    create(:invoice_item, quantity: 1, unit_price: 10.00, invoice_id: invoice2.id, item_id: create(:item, unit_price: 10.00).id)

    invoice3 = create(:invoice, merchant_id: merchant2.id, status: 'shipped', created_at: '2020-04-01T00:00:00 UTC')
    create(:transaction, result: 'success', invoice_id: invoice3.id)
    create(:invoice_item, quantity: 1, unit_price: 20.00, invoice_id: invoice3.id, item_id: create(:item, unit_price: 20.00).id)

    invoice4 = create(:invoice, merchant_id: merchant2.id, status: 'shipped', created_at: '2020-06-05T00:00:00 UTC')
    create(:transaction, result: 'failed', invoice_id: invoice4.id)
    create(:invoice_item, quantity: 1, unit_price: 20.00, invoice_id: invoice4.id, item_id: create(:item, unit_price: 20.00).id)

    invoice5 = create(:invoice, merchant_id: merchant3.id, status: 'shipped', created_at: '2020-06-02T00:00:00 UTC')
    create(:transaction, result: 'success', invoice_id: invoice5.id)
    create(:invoice_item, quantity: 1, unit_price: 30.24, invoice_id: invoice5.id, item_id: create(:item, unit_price: 30.00).id)

    invoice6 = create(:invoice, merchant_id: merchant3.id, status: 'shipped', created_at: '2020-06-01T00:00:00 UTC')
    create(:transaction, result: 'failed', invoice_id: invoice6.id)
    create(:invoice_item, quantity: 1, unit_price: 30.00, invoice_id: invoice6.id, item_id: create(:item, unit_price: 30.00).id)

    invoice7 = create(:invoice, merchant_id: merchant4.id, status: 'packaged', created_at: '2020-04-12T00:00:00 UTC')
    create(:transaction, result: 'success', invoice_id: invoice7.id)
    create(:invoice_item, quantity: 1, unit_price: 40.00, invoice_id: invoice7.id, item_id: create(:item, unit_price: 40.00).id)

    invoice8 = create(:invoice, merchant_id: merchant4.id, status: 'shipped', created_at: '2020-05-14T00:00:00 UTC')
    create(:transaction, result: 'failed', invoice_id: invoice8.id)
    create(:invoice_item, quantity: 1, unit_price: 40.00, invoice_id: invoice8.id, item_id: create(:item, unit_price: 40.00).id)

    invoice9 = create(:invoice, merchant_id: merchant5.id, status: 'shipped', created_at: '2020-01-01T00:00:00 UTC')
    create(:transaction, result: 'success', invoice_id: invoice9.id)
    create(:invoice_item, quantity: 1, unit_price: 50.67, invoice_id: invoice9.id, item_id: create(:item, unit_price: 50.00).id)

    invoice10 = create(:invoice, merchant_id: merchant5.id, status: 'shipped', created_at: '2020-01-01T00:00:00 UTC')
    create(:transaction, result: 'failed', invoice_id: invoice10.id)
    create(:invoice_item, quantity: 1, unit_price: 50.00, invoice_id: invoice10.id, item_id: create(:item, unit_price: 50.00).id)

    merchants_revenue = 50.24
    incorrect_revenue = 150.00

    start_date = '2020-04-01T00:00:00 UTC'
    end_date = '2020-06-30T00:00:00 UTC'
    get "/api/v1/revenue?start=#{start_date}&end=#{end_date}"

    expect(response).to be_successful
    result = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(result).to be_a Hash
    expect(result[:id]).to eq(nil)
    expect(result[:type]).to eq('revenue')
    expect(result[:attributes][:revenue]).to eq(merchants_revenue)
    expect(result[:attributes][:revenue]).to_not eq(incorrect_revenue)
  end
end
