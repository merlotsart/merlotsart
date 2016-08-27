require "rails_helper"
require 'webmock/rspec'

RSpec.describe ProcessBilling do
  describe ".process" do
    context "when successful" do
      it "returns a processed transaction" do
        VCR.use_cassette("braintree_transaction_sale") do
          response = ProcessBilling.process("fake-valid-nonce", "50.00")

          expect(response.class).to eq Braintree::SuccessfulResult
        end
      end
    end

    context "when unsuccessful" do
      it "returns an error response" do
        VCR.use_cassette("failed_braintree_transaction_sale") do
          response = ProcessBilling.process("fake-processor-declined-visa-nonce", "2000.00")

          expect(response.class).to eq Braintree::ErrorResult
        end
      end
    end

    context "when not provided all required information" do
      it "raises ArgumentError when nonce is nil" do
        expect { ProcessBilling.process(nil, "50.00") }
          .to raise_error(ArgumentError, "Braintree nonce not received")
      end

      it "raises ArgumentError when amount is nil" do
        expect { ProcessBilling.process("placeholder", nil) }
          .to raise_error(ArgumentError, "Order amount not received")
      end
    end
  end
end
