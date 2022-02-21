FactoryBot.define do
  factory :service_requisition do
    user
    client
    others_withdraw { Faker::Boolean.boolean }
    device
    withdrawal_forecast { Faker::Date.between(from: Date.today,  to: Date.today + 2) }
    price { 130.5 }
    comments { Faker::Lorem.sentence(word_count: 5) }
    status { 'Aberta' }
    initial_problem { Faker::Lorem.sentence(word_count: 3) }
    device_photo { 'url-photo' }
    signed_service_order { 'url-photo-ordem-assinada' }
    reason_cancellation { '' }
  end
end
