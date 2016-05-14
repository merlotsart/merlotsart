require 'rails_helper'

RSpec.describe CheckPromo, type: :model do

  describe '#promo' do
    it 'finds the promo via the provided code' do
      promo = create(:promo)
      code = promo.code

      response = CheckPromo.new(code).promo

      expect(response).to be_a Promo
    end
  end

  describe '#redemption_remaning?' do
    it 'returns true if there are remaning uses' do
      promo = create(:promo, number_of_uses: 2)
      code = promo.code

      response = CheckPromo.new(code).redemption_remaining?

      expect(response).to be true
    end

    it 'returns false if there are no remaning uses' do
      promo = create(:promo, number_of_uses: 0)
      code = promo.code

      response = CheckPromo.new(code).redemption_remaining?

      expect(response).to be false
    end
  end

  describe '#not_expired?' do
    it 'returns true if not past the expiration date' do
      promo = create(:promo, expiration_date: '2020-01-01')
      code = promo.code

      response = CheckPromo.new(code).not_expired?

      expect(response).to be true
    end

    it 'returns false if past the expiration date' do
      promo = create(:promo, expiration_date: '2015-01-01')
      code = promo.code

      response = CheckPromo.new(code).not_expired?

      expect(response).to be false
    end
  end

  describe '#valid?' do
    it 'returns true if there is a valid promo with redemtions remaining' do
      promo = create(:promo,
                     expiration_date: '2020-01-01',
                     number_of_uses: 2)
      code = promo.code

      response = CheckPromo.new(code).valid?

      expect(response).to be true
    end
  end

  describe '#discount' do
    it "returns the promo's discount percentage" do
      promo = create(:promo, discount_percentage: 50)
      code = promo.code

      response = CheckPromo.new(code).discount

      expect(response).to eq 50
    end
  end
end
