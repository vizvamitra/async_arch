class CloseAccountingPeriodJob
  include Sidekiq::Job

  def perform(payment_cycle_id)
    AccountingPeriods::Close.new.call
  end
end
