require 'rails_helper'

RSpec.describe PublicEvent, type: :model do

  # Associations
  it { should have_many(:orders) }
  it { should have_many(:attendees) }
  it { should belong_to(:experience) }
  it { should belong_to(:location) }
  it { should belong_to(:artist) }

  # Validations
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:date) }
  it { should validate_presence_of(:start_time) }
  it { should validate_presence_of(:artist_id) }
  it { should validate_presence_of(:available_slots) }
  it { should validate_presence_of(:end_time) }
  it { should validate_presence_of(:price) }
  it { should validate_presence_of(:experience) }
  it { should validate_presence_of(:location) }
  it { should validate_presence_of(:artist) }
  it { should validate_presence_of(:byob_fee) }

  describe '#quantity_available' do
    it 'returns the available slots with locks included' do
      experience = create(:experience)
      location = create(:location)
      artist = create(:artist)
      public_event = create(:public_event)

      response = public_event.quantity_available

      expect(response).to eq 9
    end
  end

  describe '#num_slots_unsold' do
    it 'reutrns the number of unsold slots' do
      
    end
  end

  describe '#slots_unsold' do
    it '' do
      
    end
  end

  describe '#num_slots_locked' do
    it '' do
      
    end
  end

  describe '#slots_locked' do
    it '' do
      
    end
  end

  describe '#slots_unlocked' do
    it '' do
      
    end
  end

  describe '#create_slots' do
    it '' do
      
    end
  end

  describe '#expired?' do
    it '' do
      
    end
  end

  describe '#update_slots' do
    it '' do
      
    end
  end

  describe '#string_with_url' do
    it '' do
      
    end
  end
end
