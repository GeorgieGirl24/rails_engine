FactoryBot.define do
  factory :customer do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }

    trait :with_items do
      transient do
        items { 2 }
      end
      after :create do |customer, evaluator|
        # if you call this in the test
        #   merchant = create(:merchant, :with_items, items: 3)
        create_list(:items, evaluator.items, customer: customer)
      end
    end
  end
end
