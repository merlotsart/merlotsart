require 'rails_helper'

RSpec.describe Attendee, type: :model do

  # Associations
  it { should belong_to(:order) }
  it { should belong_to(:public_event) }
  it { should belong_to(:private_event) }
end
