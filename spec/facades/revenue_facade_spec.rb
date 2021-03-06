require 'rails_helper'

RSpec.describe RevenueFacade do
  describe 'class methods' do

    it '.total_revenue' do
      merchant1 = create(:merchant)
      merchant2 = create(:merchant)
      merchant3 = create(:merchant)
      merchant4 = create(:merchant)
      merchant5 = create(:merchant)

      invoice1 = create(:invoice,
                        merchant_id: merchant1.id,
                        status: 'shipped',
                        created_at: '2020-01-01T00:00:00 UTC')
      create(:transaction, result: 'success', invoice_id: invoice1.id)
      create(:invoice_item,
            quantity: 1,
            unit_price: 10.00,
            invoice_id: invoice1.id,
            item_id: create(:item, unit_price: 10.00).id)

      invoice2 = create(:invoice,
                        merchant_id: merchant1.id,
                        status: 'shipped',
                        created_at: '2020-02-01T00:00:00 UTC')
      create(:transaction, result: 'failed', invoice_id: invoice2.id)
      create(:invoice_item,
            quantity: 1,
            unit_price: 10.00,
            invoice_id: invoice2.id,
            item_id: create(:item, unit_price: 10.00).id)

      invoice3 = create(:invoice,
                        merchant_id: merchant2.id,
                        status: 'shipped',
                        created_at: '2020-04-01T00:00:00 UTC')
      create(:transaction, result: 'success', invoice_id: invoice3.id)
      create(:invoice_item,
            quantity: 1,
            unit_price: 20.00,
            invoice_id: invoice3.id,
            item_id: create(:item, unit_price: 20.00).id)

      invoice4 = create(:invoice,
                        merchant_id: merchant2.id,
                        status: 'shipped',
                        created_at: '2020-06-05T00:00:00 UTC')
      create(:transaction, result: 'failed', invoice_id: invoice4.id)
      create(:invoice_item,
            quantity: 1,
            unit_price: 20.00,
            invoice_id: invoice4.id,
            item_id: create(:item, unit_price: 20.00).id)

      invoice5 = create(:invoice,
                      merchant_id: merchant3.id,
                      status: 'shipped',
                      created_at: '2020-06-02T00:00:00 UTC')
      create(:transaction, result: 'success', invoice_id: invoice5.id)
      create(:invoice_item,
            quantity: 1,
            unit_price: 30.00,
            invoice_id: invoice5.id,
            item_id: create(:item, unit_price: 30.00).id)

      invoice6 = create(:invoice,
                        merchant_id: merchant3.id,
                        status: 'packaged',
                        created_at: '2020-06-01T00:00:00 UTC')
      create(:transaction, result: 'failed', invoice_id: invoice6.id)
      create(:invoice_item,
            quantity: 1,
            unit_price: 30.00,
            invoice_id: invoice6.id,
            item_id: create(:item, unit_price: 30.00).id)

      invoice7 = create(:invoice,
                        merchant_id: merchant4.id,
                        status: 'shipped',
                        created_at: '2020-04-12T00:00:00 UTC')
      create(:transaction, result: 'success', invoice_id: invoice7.id)
      create(:invoice_item,
            quantity: 1,
            unit_price: 40.00,
            invoice_id: invoice7.id,
            item_id: create(:item, unit_price: 40.00).id)

      invoice8 = create(:invoice,
                        merchant_id: merchant4.id,
                        status: 'shipped',
                        created_at: '2020-05-14T00:00:00 UTC')
      create(:transaction, result: 'failed', invoice_id: invoice8.id)
      create(:invoice_item,
            quantity: 1,
            unit_price: 40.00,
            invoice_id: invoice8.id,
            item_id: create(:item, unit_price: 40.00).id)

      invoice9 = create(:invoice,
                        merchant_id: merchant5.id,
                        status: 'shipped',
                        created_at: '2020-01-01T00:00:00 UTC')
      create(:transaction, result: 'success', invoice_id: invoice9.id)
      create(:invoice_item,
            quantity: 1,
            unit_price: 50.00,
            invoice_id: invoice9.id,
            item_id: create(:item, unit_price: 50.00).id)

      invoice10 = create(:invoice,
                        merchant_id: merchant5.id,
                        status: 'shipped',
                        created_at: '2020-01-01T00:00:00 UTC')
      create(:transaction, result: 'failed', invoice_id: invoice10.id)
      create(:invoice_item,
              quantity: 1,
              unit_price: 50.00,
              invoice_id: invoice10.id,
              item_id: create(:item, unit_price: 50.00).id)

      merchants_revenue = 90.00
      incorrect_revenue = 300.00

      start_date = '2020-04-01T00:00:00 UTC'
      end_date = '2020-06-30T00:00:00 UTC'

      total = RevenueFacade.total_revenue(start_date, end_date)

      expect(total).to be_a Revenue
      expect(total.revenue).to eq(merchants_revenue)
      expect(total.revenue).to_not eq(incorrect_revenue)
      expect(total.id).to eq(nil)
    end
  end
end
