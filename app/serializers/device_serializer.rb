class DeviceSerializer < ActiveModel::Serializer
  attributes :id, :name, :brand, :model, :device_type_id
end
