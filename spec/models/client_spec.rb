require 'rails_helper'

RSpec.describe Client, type: :model do
  describe 'validations' do
    subject { create(:client) }
    it { should validate_presence_of(:full_name) }
    it { should validate_presence_of(:cpf) }
    it { should validate_uniqueness_of(:cpf).case_insensitive }
  end

  describe 'associations' do
    it { should belong_to(:address) }
  end
end