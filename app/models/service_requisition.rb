class ServiceRequisition < ApplicationRecord
  belongs_to :user
  belongs_to :client
  belongs_to :device

  validates :others_withdraw, :withdrawal_forecast, :price, :status
            :delivery_forecast, :initial_problem, :signed_service_order, 
            presence: true
end
