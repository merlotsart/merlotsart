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
      public_event = create(:public_event, available_slots: 3)
      public_event.attendees.first.update_attribute(:locked_until,
                                                    Time.now + 900)

      response = public_event.quantity_available

      expect(response).to eq 2
    end
  end

  describe '#num_slots_unsold' do
    it 'reutrns the number of unsold slots' do
      public_event = create(:public_event, available_slots: 3,
                            purchased_slots: 0)
      public_event.attendees.first.update_attribute(:name, 'Albert Attendee')

      response = public_event.num_slots_unsold

      expect(response).to eq 2
    end
  end

  describe '#slots_unsold' do
    it 'returns the Attendees where the name attribute is nil' do
      public_event = create(:public_event, available_slots: 3,
                            purchased_slots: 0)
      public_event.attendees.first.update_attribute(:name, 'Albert Attendee')

      response = public_event.slots_unsold

      expect(response.count).to eq 2
      expect(response).to be_a ActiveRecord::Relation
      expect(response.first).to be_a Attendee
    end
  end

  describe '#num_slots_sold' do
    it 'returns the number of Attendees where name is not nil' do
      public_event = create(:public_event, available_slots: 3,
                            purchased_slots: 0)
      public_event.attendees.first.update_attribute(:name, 'Albert Attendee')

      response = public_event.num_slots_sold

      expect(response).to eq 1
    end
  end

  describe '#num_slots_locked' do
    it 'returns the number of locked slots' do
      public_event = create(:public_event, available_slots: 3,
                            purchased_slots: 0)
      public_event.attendees.first.update_attribute(:locked_until,
                                                    Time.now + 900)

      response = public_event.num_slots_locked

      expect(response).to be 1
    end
  end

  describe '#slots_locked' do
    it 'returns the Attendees where locked_until is greater than the current time' do
      public_event = create(:public_event, available_slots: 3,
                            purchased_slots: 0)
      public_event.attendees.first.update_attribute(:locked_until,
                                                    Time.now + 900)

      response = public_event.slots_locked

      expect(response.count).to be 1
      expect(response).to be_a ActiveRecord::Relation
      expect(response.first).to be_a Attendee
    end
  end

  describe '#slots_unlocked' do
    it 'returns the Attendees where locked_until is less than the current time' do
      public_event = create(:public_event, available_slots: 3,
                            purchased_slots: 0)
      public_event.attendees.first.update_attribute(:locked_until,
                                                    Time.now + 900)

      response = public_event.slots_unlocked

      expect(response.count).to be 2
      expect(response).to be_a ActiveRecord::Relation
      expect(response.first).to be_a Attendee
    end
  end

  describe '#create_slots' do
    it 'creates Attendee records for the total number of available slots' do
      # Used in after_create callback. Functionality needs update or method
      # needs to be private.
      public_event = create(:public_event, available_slots: 3,
                            purchased_slots: 0)

      expect(public_event.attendees.count).to eq 3
    end
  end

  describe '#expired?' do
    it 'returns true if the date attribute is prior to today' do
      public_event = create(:public_event, date: '2016-01-01')

      Timecop.freeze('2016-01-02')
      response = public_event.expired?
      Timecop.return

      expect(response).to be true
    end

    it 'returns false if the date attribute is after today' do
      public_event = create(:public_event, date: '2016-01-02')

      Timecop.freeze('2016-01-01')
      response = public_event.expired?
      Timecop.return

      expect(response).to be false
    end

    it 'returns false if the date attribute is the same as today' do
      public_event = create(:public_event, date: '2016-01-01')

      Timecop.freeze('2016-01-01')
      response = public_event.expired?
      Timecop.return

      expect(response).to be false
    end
  end

  describe '#update_slots' do
    context 'when removing slots' do
      it 'deletes unused Attendees' do
        public_event = create(:public_event, available_slots: 3,
                              purchased_slots: 0)
        public_event.update_column(:available_slots, 2)

        expect { public_event.update_slots }
          .to change{Attendee.count}.from(3).to(2)
      end

      it 'does not affect sold slots' do
        # The method for this test is bad and needs refactoring. As you can see
        # by the test, attendees vs available slots are now out of sync.
        public_event = create(:public_event, available_slots: 3,
                              purchased_slots: 0)
        public_event.attendees.first.update_attribute(:name, 'Albert Attendee')
        public_event.attendees.second.update_attribute(:name, 'Ashton Attendee')
        public_event.update_column(:available_slots, 1)

        expect { public_event.update_slots }
          .to change{Attendee.count}.from(3).to(2)
      end
    end

    context 'when adding slots' do
      it 'creates addtional Attendees' do
        public_event = create(:public_event, available_slots: 3,
                              purchased_slots: 0)
        public_event.update_column(:available_slots, 2)

        expect { public_event.update_slots }
          .to change{Attendee.count}.from(3).to(2)
      end
    end
  end

  describe '#string_with_url' do
    context 'when given a string with http' do
      it 'it converts the http word into a link' do
        public_event = create(:public_event)
        string = 'A http://some_domain.com type string'

        response = public_event.string_with_url(string)

        expect(response).to include "<a href='http://some_domain.com'"
      end
    end

    context 'when given a string with www' do
      it 'it converts the http word into a link' do
        public_event = create(:public_event)
        string = 'A www.some_domain.com type string'

        response = public_event.string_with_url(string)

        expect(response).to include "<a href='http://www.some_domain.com'"
      end
    end

    context 'when given a string with .com' do
      it 'it converts the http word into a link' do
        public_event = create(:public_event)
        string = 'A some_domain.com type string'

        response = public_event.string_with_url(string)

        expect(response).to include "<a href='http://some_domain.com'"
      end
    end

    context 'when given a string with without any matchers' do
      it 'returns the sting' do
        public_event = create(:public_event)
        string = 'A some_domain type string'

        response = public_event.string_with_url(string)

        expect(response).to eq string
      end
    end

  end
end
