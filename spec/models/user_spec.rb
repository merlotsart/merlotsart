require 'rails_helper'

RSpec.describe User, type: :model do

  # Associations
  it { should have_many(:orders) }

  # Validations
  it { should validate_presence_of(:name) }

  it { should allow_value('555-555-1234').for(:phone) }
  it { should_not allow_value('555-1234').for(:phone) }
  it { should_not allow_value('aaa-aaa-aaaa').for(:phone) }
end
