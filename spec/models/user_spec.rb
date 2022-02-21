require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should define_enum_for(:role) }
  end

  describe 'associations' do
    it { should have_many(:service_requisitions) }
  end
end
