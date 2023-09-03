module AccountingPeriods
  class CloseRevenuesAndExpenses
    def initialize(close_revenue: Operations::CloseRevenue.new,
                  close_expense: Operations::CloseExpense.new,
                  close_income_summary: Operations::CloseIncomeSummary.new)
      @_close_revenue = close_revenue
      @_close_expense = close_expense
      @_close_income_summary = close_income_summary
    end

    def call
      Account.revenue.each { |account| close_revenue(account) }
      Account.expense.each { |account| close_expense(account) }

      close_income_summary
    end

    private

    attr_reader :_close_revenue, :_close_expense, :_close_income_summary

    def close_revenue(account)
      _close_revenue.call(account:)
    end

    def close_expense(account)
      _close_expense.call(account:)
    end

    def close_income_summary
      _close_income_summary.call
    end
  end
end
