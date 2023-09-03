module PaymentCycles
  class Switch
    # @param employee [Employee]
    #
    # @return [void]
    #
    def call(employee:)
      current = employee.payment_cycles.current

      ActiveRecord::Base.transaction do
        close_cycle(current) if current
        next_cycle = open_next_cycle(employee, current)

        ClosePaymentCycleJob.perform_at(next_cycle.date.end_of_day, next_cycle.id)
      end
    end

    private

    def close_cycle(cycle)
      cycle.update!(closed: true, closed_at: Time.current)
    end

    def open_next_cycle(employee, prev_cycle)
      date = prev_cycle ? prev_cycle.date.next_day : Date.today

      employee.payment_cycles.create!(date:)
    end
  end
end
