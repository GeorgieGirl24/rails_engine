FactoryBot.define do
  factory :merchant do
    name { Faker::Name.name }

    trait :with_items do
      transient do
        items { 2 }
      end
      after :create do |merchant, evaluator|
        # if you call this in the test
        #   merchant = create(:merchant, :with_items, items: 3)
        create_list(:items, evaluator.items, merchant: merchant)
      end
    end
  end
end
