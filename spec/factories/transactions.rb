FactoryBot.define do
  factory :transaction do
    credit_card_number { Faker::Finance.credit_card(:visa) }
    result { 'success' }
    invoice_id { Faker::Number.within(range: 0..100_000) }
    invoice
  end
end
