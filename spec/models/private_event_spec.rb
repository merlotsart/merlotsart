require 'rails_helper'

RSpec.describe PrivateEvent, type: :model do

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
  it { should validate_presence_of(:end_time) }
  it { should validate_presence_of(:available_slots) }
  it { should validate_presence_of(:phone) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:how_hear) }
end
