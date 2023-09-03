module FinancialStatements
  class Prepare
    def initialize(prepare_income_statement: PrepareIncomeStatement.new)
      @_prepare_income_statement = prepare_income_statement
    end

    def call
      period = AccountingPeriod.current

      prepare_income_statement(period)
      # TODO: prepare_balance_sheet(period)
    end

    private

    attr_reader :_prepare_income_statement

    def prepare_income_statement(period)
      _prepare_income_statement.call(period:)
    end
  end
end
