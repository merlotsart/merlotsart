require 'rails_helper'

RSpec.describe Order, type: :model do

  # Associations
  it { should belong_to(:user) }
  it { should belong_to(:public_event) }
  it { should belong_to(:private_event) }
  it { should have_many(:attendees) }
  it { should accept_nested_attributes_for(:attendees) }

  # Validations
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:phone) }

  describe '#locked_slots' do
    it 'returns the number of locked slots' do
      public_event = create(:public_event)
      order = create(:order, public_event: public_event)

      response = order.locked_slots

      expect(response).to eq 1
    end
  end
end
