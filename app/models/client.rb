class Client < ApplicationRecord
  belongs_to :address

  validates :full_name, presence: true
  validates :cpf, uniqueness: true, cpf: true
end
