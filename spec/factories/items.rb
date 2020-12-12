FactoryBot.define do
  FactoryBot.define do
    factory :item do
      name { Faker::Book.title }
      description { Faker::Lorem.paragraph(sentence_count: 15, supplemental: true, random_sentences_to_add: 5)}
      unit_price { Faker::Number.decimal(l_digits: (Faker::Number.within(range: 1..10)), r_digits: 2)}
      merchant_id { Faker::Number.within(range: 0..100000) }
      merchant
    end
  end
end
