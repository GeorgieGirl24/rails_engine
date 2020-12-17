require 'rails_helper'

RSpec.describe 'Single Merchant Revenue' do
  scenario 'can return the total revenue for a particular Merchant' do
    merchant1 = create(:merchant)

    invoice1 = create(:invoice, merchant_id: merchant1.id, status: 'shipped', created_at: '2020-04-12T00:00:00 UTC')
    create(:transaction, result: 'success', invoice_id: invoice1.id)
    create(:invoice_item, quantity: 1, unit_price: 100.12, invoice_id: invoice1.id, item_id: create(:item, unit_price: 10.00).id)

    invoice2 = create(:invoice, merchant_id: merchant1.id, status: 'packaged', created_at: '2020-06-01T00:00:00 UTC')
    create(:transaction, result: 'failed', invoice_id: invoice2.id)
    create(:invoice_item, quantity: 1, unit_price: 1_000.00, invoice_id: invoice2.id, item_id: create(:item, unit_price: 10.00).id)

    invoice3 = create(:invoice, merchant_id: merchant1.id, status: 'shipped', created_at: '2020-02-01T00:00:00 UTC')
    create(:transaction, result: 'success', invoice_id: invoice3.id)
    create(:invoice_item, quantity: 1, unit_price: 12_000.53, invoice_id: invoice3.id, item_id: create(:item, unit_price: 20.00).id)

    invoice4 = create(:invoice, merchant_id: merchant1.id, status: 'shipped', created_at: '2020-04-01T00:00:00 UTC')
    create(:transaction, result: 'success', invoice_id: invoice4.id)
    create(:invoice_item, quantity: 1, unit_price: 20.09, invoice_id: invoice4.id, item_id: create(:item, unit_price: 20.00).id)

    invoice5 = create(:invoice, merchant_id: merchant1.id, status: 'shipped', created_at: '2020-06-05T00:00:00 UTC')
    create(:transaction, result: 'success', invoice_id: invoice5.id)
    create(:invoice_item, quantity: 1, unit_price: 347.00, invoice_id: invoice5.id, item_id: create(:item, unit_price: 30.00).id)

    invoice6 = create(:invoice, merchant_id: merchant1.id, status: 'shipped', created_at: '2020-06-02T00:00:00 UTC')
    create(:transaction, result: 'failed', invoice_id: invoice6.id)
    create(:invoice_item, quantity: 1, unit_price: 30.00, invoice_id: invoice6.id, item_id: create(:item, unit_price: 30.00).id)

    total_revenue = 12467.74
    incorrect_revenue = 13497.74
    merchant_id = merchant1.id
    get "/api/v1/merchants/#{merchant_id}/revenue"

    expect(response).to be_successful

    result = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(result).to be_a Hash
    expect(result).to_not be_a Array
    expect(result[:attributes][:revenue]).to eq(total_revenue)
    expect(result).to_not eq(total_revenue)
  end
end
