FactoryBot.define do
  factory :device do
    name { Faker::Device.model_name }
    brand { Faker::Device.manufacturer }
    model { Faker::Device.serial }
    device_type
  end
end
