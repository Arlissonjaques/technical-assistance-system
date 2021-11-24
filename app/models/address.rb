class Address < ApplicationRecord

  validates :street, :district, :complement, presence: true
  validates :number, length: { maximum: 4 }
  validates :complement, length: { maximum: 80 }
end
