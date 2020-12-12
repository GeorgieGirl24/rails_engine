FactoryBot.define do
  FactoryBot.define do
    factory :invoice_item do
      quantity { Faker::Number.within(range: 1..30) }
      unit_price { Faker::Commerce.price(range: 0..100000.0) }
      item_id { Faker::Number.within(range: 0..100000) }
      invoice_id { Faker::Number.within(range: 0..100000) }
      item 
      invoice
    end
  end
end
