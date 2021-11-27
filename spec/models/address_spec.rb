require 'rails_helper'

RSpec.describe Address, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:street) }
    it { should validate_presence_of(:district) }
    it { should validate_presence_of(:complement) }
    it { should validate_length_of(:number) }
    it { should validate_length_of(:complement) }
  end

  describe 'associations' do
    it { should have_one(:client) }
  end
end