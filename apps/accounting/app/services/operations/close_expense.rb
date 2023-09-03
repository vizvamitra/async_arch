module Operations
  class CloseExpense
    KIND = :expense_closing
    DESCRIPTION = "End of period expense closing"

    def initialize(create_transfer: Transfers::Create.new)
      @_create_transfer = create_transfer
    end

    def call(account:)
      amount = account.balance

      entries = build_entries(account, amount)
      create_transfer(entries)
    end

    private

    attr_reader :_create_transfer

    def build_entries(account, amount)
      [
        build_entry(:debit, income_summary_account, amount),
        build_entry(:credit, account, amount),
      ]
    end

    def create_transfer(entries)
      _create_transfer.call(
        entries:,
        kind: KIND,
        description: DESCRIPTION,
        reference: nil
      )
    end

    def build_entry(side, account, amount)
      Entries::Attributes.new(side:, account:, amount:)
    end

    def income_summary_account
      Account.income_summary_temporary
    end
  end
end
