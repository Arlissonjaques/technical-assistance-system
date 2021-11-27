class AddressSerializer < ActiveModel::Serializer
  attributes :id, :street, :district, :number, :complement
end
