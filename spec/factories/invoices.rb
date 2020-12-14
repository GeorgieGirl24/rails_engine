FactoryBot.define do
  factory :invoice do
    status { 'shipped' }
    customer_id { Faker::Number.within(range: 0..100_000) }
    merchant_id { Faker::Number.within(range: 0..100_000) }
    customer
    merchant
  end
end
