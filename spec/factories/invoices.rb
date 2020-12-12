FactoryBot.define do
  FactoryBot.define do
    factory :invoice do
      status { 'shipped' }
      customer_id { Faker::Number.within(range: 0..100000) }
      merchant_id { Faker::Number.within(range: 0..100000) }
      customer
      merchant
    end
  end
end
