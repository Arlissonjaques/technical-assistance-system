require 'rails_helper'

RSpec.describe Device, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:brand) }
    it { should validate_presence_of(:model) }
    it { should validate_presence_of(:name) }
  end

  describe 'associations' do
    it { should belong_to(:device_type) }
  end
end