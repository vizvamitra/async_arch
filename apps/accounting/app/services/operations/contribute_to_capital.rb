module Operations
  class ContributeToCapital
    KIND = :contribution
    DESCRIPTION = "Contribution to capital"

    def initialize(create_transfer: Transfers::Create.new)
      @_create_transfer = create_transfer
    end

    def call(amount:)
      entries = build_entries(amount)
      create_transfer(entries)
    end

    private

    attr_reader :_create_transfer

    def build_entries(amount)
      [
        build_entry(:debit, cash_account, amount),
        build_entry(:credit, capital_account, amount),
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

    def cash_account
      Account.cash_asset
    end

    def capital_account
      Account.capital_equity
    end
  end
end
