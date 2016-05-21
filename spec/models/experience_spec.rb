require 'rails_helper'

RSpec.describe Experience, type: :model do

  # Associations
  it { should have_many(:public_event) }
  it { should have_many(:private_event) }
end
