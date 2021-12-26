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
end