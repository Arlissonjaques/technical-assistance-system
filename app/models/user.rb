class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :service_requisitions

  validates :name, :email, presence: true
  enum role: %i[employee manager admin]

  ROLE_EMPLOYEE = 0
  ROLE_MANAGER = 1
  ROLE_ADMIN = 2
end