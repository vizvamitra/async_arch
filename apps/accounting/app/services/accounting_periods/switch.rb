module AccountingPeriods
  class Switch
    PERIOD_LENGTH = 1.day
    DESCRIPTION_FORMAT = "%<start>s - %<end>s"

    def call
      current = AccountingPeriod.current

      close(current)
      next_period = open_next_period(prev_period)

      schedule_closing(next_period)
    end

    private

    def close(period)
      current&.update!(closed: true, closed_at: Time.current)
    end

    def open_next_period(prev_period)
      AccountingPeriod.create!(
        start: (prev_period&.start || Date.yesterday) + PERIOD_LENGTH,
        end: (prev_period&.end || Date.yesterday) + PERIOD_LENGTH,
        description: format(DESCRIPTION_FORMAT, start:, end: end_)
      )
    end

    def schedule_closing(period)
      CloseAccountingPeriodJob.perform_at(period.end.end_of_day)
    end
  end
end
