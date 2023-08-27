module FinancialStatements
  class PrepareIncomeStatement
    def call(period:)
      statement = create_income_statement(period)

      add_line_items(statement, :revenues, revenue_entries(period))
      add_line_items(statement, :expenses, expense_entries(period))

      add_total(statement, net_income_loss_entry(period))

      statement.save!
    end

    private

    def create_income_statement(period)
      FinancialStatement.income_statement.create!(accounting_period: period)
    end

    def revenue_entries(period)
      entries(period, :revenue_closing)
    end

    def expense_entries(period)
      entries(period, :expense_closing)
    end

    def net_income_loss_entry(period)
      entries(period, :income_summary_closing).first
    end

    def entries(period, kind)
      income_sumary_account
        .transfers
        .for(period)
        .where(kind:)
        .includes(:entries)
        .flat_map { |t| t.entries.where.not(account: income_sumary_account) }
    end

    def add_line_items(statement, section, entries)
      position = 0

      entries.each do |entry|
        add_line_item(statement, section, entry.account.name, entry.amount, position)
        position += 1
      end

      add_line_item(statement, section, "Total", entries.sum(&:amount), position + 1)
    end

    def add_line_item(statement, section, label, amount, position)
      item = statement
        .line_items
        .new(section:, label:, amount:, section_position: position)

      statement.line_items << item
    end

    def add_total(statement, entry)
      add_line_item(
        statement,
        :net_income,
        "Total",
        (entry.debit? ? 1 : -1) * entry.amount,
        0
      )
    end

    def income_sumary_account
      Account.income_summary_temporary
    end
  end
end
