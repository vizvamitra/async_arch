module Operations
  class ChargeTaskAssignmentFee
    KIND = :task_assignment_fee
    DESCRIPTION = "Task assignment fee"

    def initialize(create_transfer: Transfers::Create.new)
      @_create_transfer = create_transfer
    end

    def call(account:, amount:, reference:)
      entries = build_entries(account, amount)
      create_transfer(reference, entries)
    end

    private

    attr_reader :_create_transfer

    def build_entries(account, amount)
      [
        build_entry(:debit, account, amount),
        build_entry(:credit, revenue_account, amount),
      ]
    end

    def create_transfer(reference, entries)
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

    def revenue_account
      Account.task_assignment_revenue
    end
  end
end
