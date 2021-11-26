class Client < ApplicationRecord
  belongs_to :address

  validates :cpf, cpf: true # this activates cpf validation
  validates :full_name, :cpf, presence: true
  validates_uniqueness_of :cpf, case_sensitive: false
end
