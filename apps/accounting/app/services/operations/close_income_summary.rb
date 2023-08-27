module Operations
  class CloseIncomeSummary
    KIND = :income_summary_closing
    DESCRIPTION = "End of period income summary closing"

    def initialize(create_transfer: Transfers::Create.new)
      @_create_transfer = create_transfer
    end

    def call
      amount = income_summary_account.balance

      entries = build_entries(amount)
      create_transfer(entries)
    end

    private

    attr_reader :_create_transfer

    def build_entries(amount)
      [
        build_entry(:debit, capital_account, amount),
        build_entry(:credit, income_summary_account, amount),
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

    def capital_account
      Account.capital_equity
    end

    def income_summary_account
      Account.income_summary_temporary
    end
  end
end
