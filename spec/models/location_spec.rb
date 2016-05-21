require 'rails_helper'

RSpec.describe Location, type: :model do

  # Associations
  it { should have_many(:public_event) }
  it { should have_many(:private_event) }

  # Validations
  it { should validate_presence_of(:name) }
end
