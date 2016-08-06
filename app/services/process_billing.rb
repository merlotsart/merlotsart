class ProcessBilling

  def initialize(nonce, amount)
    raise ArgumentError.new("Braintree nonce not received") unless nonce
    raise ArgumentError.new("Order amount not received") unless amount

    @nonce = nonce || NullNonceError.new
    @amount = amount || NullAmountError.new
  end

  def self.process(nonce, amount)
    self.new(nonce, amount).process
  end

  def process
    run_transaction
  end

  private

  def run_transaction
    Braintree::Transaction.sale(
      amount: @amount,
      payment_method_nonce: @nonce,
      options: { submit_for_settlement: true }
    )
  end
end
