module Operations
  class PayoutToEmployee
    KIND = :payout_to_employee
    DESCRIPTION = "Payout to employee"

    def initialize(create_transfer: Transfers::Create.new)
      @_create_transfer = create_transfer
    end

    def call(account:, amount:, reference:)
      entries = build_entries(account, amount)
      create_transfer(entries, reference)
    end

    private

    attr_reader :_create_transfer

    def build_entries(account, amount)
      [
        build_entry(:debit, account, amount),
        build_entry(:credit, cash_account, amount),
      ]
    end

    def create_transfer(entries, reference)
      _create_transfer.call(
        entries:,
        kind: KIND,
        description: DESCRIPTION,
        reference:
      )
    end

    def build_entry(side, account, amount)
      Entries::Attributes.new(side:, account:, amount:)
    end

    def cash_account
      Account.cash_asset
    end
  end
end
