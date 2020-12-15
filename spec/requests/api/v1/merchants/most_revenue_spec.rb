require 'rails_helper'

RSpec.describe 'Finds the Merchant with the hightest revenue' do
  scenario 'returns 3 top merchants with the hightest revenue' do
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

    # merchant1_revenue = 10.00
    # merchant2_revenue = 20.00
    # merchant3_revenue = 30.00
    # merchant4_revenue = 40.00
    # merchant5_revenue = 50.00

    number_of_merchants = 3
    GET "/api/v1/merchants/most_revenue?quantity=#{number_of_merchants}"

    expect(response).to be_successful
    results = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(results).to be_a Array
    expect(results.count).to eq(3)
    results.each do |result|
      expect(result[:id]).to eq(merchant5.id).or(eq merchant4.id).or(eq merchant3.id)
      expect(result[:id]).to_not eq(merchant1.id).or(eq merchant2.id)
      expect(result[:type]).to eq('merchant')
      expect(result[:attributes][:name]).to eq(merchant5.name).or(eq merchant4.name).or(eq merchant3.name)
    end
  end 
end
