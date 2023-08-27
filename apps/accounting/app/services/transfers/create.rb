module Transfers
  class Create
    # @param entries [Array<Entries::Attributes>]
    # @param kind [Symbol]
    # @param descrption [String]
    # @param reference [Task]
    #
    # @return [Transfer]
    # @raise [Errors::AmountsNotEvenError]
    #
    def call(entries:, kind:, description:, reference: nil)
      raise Errors::AmountsNotEvenError if !balance_diff(entries).zero?

      ActiveRecord::Base.transaction do
        create_transfer(entries, kind, description, reference)
      end
    end

    private

    attr_reader :_send_event

    def balance_diff(entries)
      entries.select(&:debit?).sum(&:amount) - entries.select(&:credit?).sum(&:amount)
    end

    def create_transfer(entries, kind, description, reference)
      Transfer.create!(
        entries: entries.map { |e| Entry.new(e.to_h) },
        kind:,
        description:,
        reference:,
        accounting_period: current_period
      )
    end

    def current_period
      AccountingPeriod.current
    end
  end
end
