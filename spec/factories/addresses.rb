FactoryBot.define do
  factory :address do
    street { Faker::Address.street_name }
    district { Faker::Address.community }
    number { Faker::Number.number(digits: 4) }
    complement { Faker::Address.secondary_address }
  end
end
