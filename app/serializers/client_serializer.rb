class ClientSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :cpf, :address_id 
end
