class ClosePaymentCycleJob
  include Sidekiq::Job

  def perform(payment_cycle_id)
    PaymentCycles::Close.new.call(cycle_id: payment_cycle_id)
  end
end
