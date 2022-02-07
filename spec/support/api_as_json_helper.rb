module ApiAsJsonHelper
  def json_parse
    JSON.parse(response.body)
  end

  def address_as_json(address)
    {
      'id' => address&.id,
      'street' => address.street,
      'district' => address.district,
      'number' => address.number,
      'complement' => address.complement
    }
  end

  def client_as_json(client)
    {
      'id' => client.id,
      'full_name' => client.full_name,
      'cpf' => client.cpf,
      'address_id' => client.address_id
    }
  end

  def device_as_json(device)
    {
      'id' => device.id,
      'name' => device.name,
      'brand' => device.brand,
      'model' => device.model,
      'device_type_id' => device.device_type_id
    }
  end
end