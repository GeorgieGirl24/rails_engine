FactoryBot.define do
  FactoryBot.define do
    factory :customer do
      first_name { Faker::Name.first_name }
      first_name { Faker::Name.last_name }
    end
  end 
end