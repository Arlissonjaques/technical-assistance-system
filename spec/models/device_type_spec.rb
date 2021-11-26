require 'rails_helper'

RSpec.describe DeviceType, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'associations' do
    it { should have_many(:devices) }
  end
end