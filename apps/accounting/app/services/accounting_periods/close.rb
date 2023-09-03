module AccountingPeriods
  class Close
    def initialize(close_revenues_and_expenses: CloseRevenuesAndExpenses.new,
                   prepare_statements: FinancialStatements::Prepare.new,
                   switch_period: Switch.new)
      @_close_revenues_and_expenses = close_revenues_and_expenses
      @_prepare_statements = prepare_statements
      @_switch_period = switch_period
    end

    def call
      ActiveRecord::Base.transaction do
        # TODO: validate trial balance

        close_revenues_and_expenses
        # TODO: close equity contributions/drawings
        # TODO: close cash in/out-flows

        prepare_statements

        switch_period
      end
    end

    private

    attr_reader :_close_revenues_and_expenses, :_prepare_statements, :_switch_period

    def close_revenues_and_expenses
      _close_revenues_and_expenses.call
    end

    def prepare_statements
      _prepare_statements.call
    end

    def switch_period
      _switch_period.call
    end
  end
end

=begin
|End of day | Task assignment (revenue v) | Income summary (^)          |
|           | Income summary (v)          | Task completion (expense v) |
|           | Income summary (?)          | Capital (equity ?)          |
|           | Employee (liabilities v)    | Cash (assets v)             |
=end
