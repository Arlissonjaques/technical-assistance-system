FactoryBot.define do
  factory :client do
    full_name { Faker::Name.name_with_middle }
    cpf { Faker::CPF.numeric }
    address
  end
end
