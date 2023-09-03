module PaymentCycles
  class Close
    def initialize(payout: Operations::PayoutToEmployee.new,
                   switch: Switch.new)
      @_payout = payout
      @_switch = switch
    end

    # @params cycle_id [Integer]
    #
    # @return [void]
    #
    def call(cycle_id:)
      cycle = PaymentCycle.find(cycle_id)

      ActiveRecord::Base.transaction do
        payout(cycle)
        switch_cycle(cycle.employee)
      end
    end

    private

    attr_reader :_payout, :_switch

    def payout(cycle)
      employee = cycle.employee
      account = employee.account

      return if account.balance <= 0

      _payout.call(
        account: account,
        amount: account.balance,
        reference: cycle
      )
    end

    def switch_cycle(employee)
      _switch.call(employee:)
    end
  end
end
