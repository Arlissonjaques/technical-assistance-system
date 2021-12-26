FactoryBot.define do
  factory :user do
    name { Faker::Name.first_name }
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 8) }

    trait :manager do
      role { 1 }
    end

    trait :admin do
      role { 2 }
    end
  end
end
