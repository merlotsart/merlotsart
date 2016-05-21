require 'rails_helper'

RSpec.describe Artist, type: :model do

  # Associations
  it { should have_many(:public_events) }
  it { should have_many(:private_events) }

  # Validations
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:bio) }
end
