class Device < ApplicationRecord
  belongs_to :device_type

  validates :brand, :model, :name, presence: true
end
