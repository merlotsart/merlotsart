require 'rails_helper'

RSpec.describe CheckPromo, type: :model do

  describe '#process_discount' do
    it 'returns the discounted total when the code is valid' do
      promo = create(:promo,
                     discount_type: :percentage,
                     discount_percentage: 50,
                     expiration_date: '2020-01-01',
                     number_of_uses: 2)
      discount_code = promo.code
      subtotal = 100

      response = CheckPromo.new(discount_code, subtotal).process_discount

      expect(response).to eq 50
    end

    it 'returns the subtotal when the code is invalid' do
      code = 'invalid'
      subtotal = 100

      response = CheckPromo.new(code, subtotal).process_discount


      expect(response).to eq subtotal
    end
  end

  describe '#valid?' do
    it 'returns true when a promo exists, has remaining redemptions, and is not expired' do
      promo = create(:promo,
                     number_of_uses: 1,
                     number_of_times_used: 0,
                     expiration_date: Date.tomorrow)
      code = promo.code
      subtotal = 10

      response = CheckPromo.new(code, subtotal).send(:valid?)

      expect(response).to be true
    end

    it 'returns nil (falsey) when a promo does not exist for the supplied code' do
      code = 'invalid'
      subtotal = 10

      response = CheckPromo.new(code, subtotal).send(:valid?)

      expect(response).to be nil
    end

    it 'returns false when a promo has no remaining redemptions' do
      promo = create(:promo,
                     number_of_uses: 1,
                     number_of_times_used: 1,
                     expiration_date: Date.tomorrow)
      code = promo.code
      subtotal = 10

      response = CheckPromo.new(code, subtotal).send(:valid?)

      expect(response).to be false
    end

    it 'returns false when a promo has expired' do
      promo = create(:promo,
                     number_of_uses: 1,
                     number_of_times_used: 0,
                     expiration_date: Date.yesterday)
      code = promo.code
      subtotal = 10

      response = CheckPromo.new(code, subtotal).send(:valid?)

      expect(response).to be false
    end
  end

  describe '#redemption_remaning?' do
    it 'returns true if there are remaning uses' do
      promo = create(:promo,
                     number_of_uses: 1,
                     number_of_times_used: 0)
      code = promo.code
      subtotal = 10

      response = CheckPromo.new(code, subtotal).send(:redemption_remaining?)

      expect(response).to be true
    end

    it 'returns false if there are no remaning uses' do
      promo = create(:promo,
                     number_of_uses: 1,
                     number_of_times_used: 1)
      code = promo.code
      subtotal = 10

      response = CheckPromo.new(code, subtotal).send(:redemption_remaining?)

      expect(response).to be false
    end
  end

  describe '#not_expired?' do
    it 'returns true if not past the expiration date' do
      promo = create(:promo, expiration_date: Date.tomorrow)
      code = promo.code
      subtotal = 10

      response = CheckPromo.new(code, subtotal).send(:not_expired?)

      expect(response).to be true
    end

    it 'returns false if past the expiration date' do
      promo = create(:promo, expiration_date: Date.yesterday)
      code = promo.code
      subtotal = 10

      response = CheckPromo.new(code, subtotal).send(:not_expired?)

      expect(response).to be false
    end
  end

  describe '#apply_discount' do
    context 'when the promo is a percentage discount' do
      it 'calculates the percentage discount' do
        promo = create(:promo,
                       discount_type: :percentage,
                       discount_percentage: 50)
        discount_code = promo.code
        subtotal = 100

        response = CheckPromo.new(discount_code, subtotal).send(:apply_discount)

        expect(response).to eq 50
      end
    end

    context 'when the promo is a amount discount' do
      it 'calculates the amount discount' do
        promo = create(:promo,
                       discount_type: :amount,
                       discount_amount: 25)
        discount_code = promo.code
        subtotal = 100

        response = CheckPromo.new(discount_code, subtotal).send(:apply_discount)

        expect(response).to eq 75
      end
    end

    context 'when the promo does not have a discount type' do
      it 'calculates the discount as if it was percentage' do
        promo = create(:promo,
                       discount_type: nil,
                       discount_percentage: 25)
        discount_code = promo.code
        subtotal = 100

        response = CheckPromo.new(discount_code, subtotal).send(:apply_discount)

        expect(response).to eq 75
      end
    end
  end

  describe '#calculate_percentage_discount' do
    it 'returns the percentage as a float' do
      promo = create(:promo, discount_percentage: 33)
      discount_code = promo.code
      subtotal = 10

      response = CheckPromo.new(discount_code, subtotal).send(:apply_discount)

      expect(response).to eq 6.7
      expect(response).to be_a Float
    end
  end

  describe '#promo' do
    xit 'finds the promo via the provided code' do
      promo = create(:promo)
      code = promo.code

      response = CheckPromo.new(code).promo

      expect(response).to be_a Promo
    end
  end

  describe '#discount' do
    context "when discount type is percentage" do
      it "returns the formatted discount percentage" do
        promo = create(:promo,
                       discount_type: :percentage,
                       discount_percentage: 50)
        discount_code = promo.code
        subtotal = 10

        response = CheckPromo.new(discount_code, subtotal).discount

        expect(response).to eq "50%"
      end
    end

    context "when discount type is amount" do
      it "returns the formatted discount amount" do
        promo = create(:promo,
                       discount_type: :amount,
                       discount_amount: 5.55)
        discount_code = promo.code
        subtotal = 10

        response = CheckPromo.new(discount_code, subtotal).discount

        expect(response).to eq "$5.55"
      end
    end

    context "when discount type is nil" do
      it "returns the formatted discount percentage" do
        promo = create(:promo, discount_percentage: 33)
        discount_code = promo.code
        subtotal = 10

        response = CheckPromo.new(discount_code, subtotal).discount

        expect(response).to eq "33%"
      end
    end
  end

end
