require 'rails_helper'

RSpec.describe LicenseeApplication, type: :model do

  # Validations
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:phone) }
  it { should validate_presence_of(:interested_locations) }

  it { should allow_value('test@email.com').for(:email) }
  it { should allow_value('sub.test@email.co.uk').for(:email) }
  it { should_not allow_value('@email.com').for(:email) }
  it { should_not allow_value('test@email').for(:email) }

  describe '#full_name' do
    it 'returns the full name' do
      licensee_application = create(:licensee_application,
                                   first_name: 'Nelly',
                                   last_name: 'Namester')

      response = licensee_application.full_name

      expect(response).to eq 'Nelly Namester'
    end
  end
end
