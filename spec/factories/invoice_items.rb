FactoryBot.define do
  factory :invoice_item do
    quantity { Faker::Number.within(range: 1..30) }
    unit_price { Faker::Commerce.price(range: 0..100_000.0) }
    item_id { Faker::Number.within(range: 0..100_000) }
    invoice_id { Faker::Number.within(range: 0..100_000) }
    item
    invoice
  end
end
