module ApiAsJsonHelper
  def json_parse
    # binding.pry
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
end