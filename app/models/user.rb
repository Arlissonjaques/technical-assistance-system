class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :validatable
  include DeviseTokenAuth::Concerns::User

  validates :name, :email, presence: true
  enum role: %i[employee manager admin]
end