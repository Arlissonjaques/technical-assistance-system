require 'rails_helper'

RSpec.describe ServiceRequisition, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:others_withdraw) }
    it { should validate_presence_of(:withdrawal_forecast) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:delivery_forecast) }
    it { should validate_presence_of(:initial_problem) }
    it { should validate_presence_of(:signed_service_order) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:client) }
    it { should belong_to(:device) }
  end
end