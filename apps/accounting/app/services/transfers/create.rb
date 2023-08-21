module Transfers
  class Create
    def initialize(send_events: Events::SendBatch.new)
      @_send_events = send_events
    end

    # @param entries [Array<Entries::Attributes>]
    # @param descrption [String]
    # @param reference [Task]
    #
    # @return [Transaction]
    # @raise [Errors::AmountsNotEvenError]
    #
    def call(entries:, description:, reference: nil)
      raise Errors::AmountsNotEvenError if !balance_diff(entries).zero?

      ActiveRecord::Base.transaction do
        transfer = create_transfer(entries, description, reference)
        send_events(transfer)

        transfer
      end
    end

    private

    attr_reader :_send_events

    def balance_diff(entries)
      entries.select(&:debit?).sum(&:amount) - entries.select(&:credit?).sum(&:amount)
    end

    def create_transfer(entries, description, reference)
      Transfer.create!(
        entries: entries.map { |e| Entry.new(e.to_h) },
        description: description,
        reference: reference,
        date: Time.current.to_date
      )
    end

    def send_events(transfer)
      events = transfer.entries.map do |entry|
        Events::Accounts::BalanceChanged::V2.new(
          account_public_id: entry.account.public_id,
          owner_public_id: entry.account.owner&.public_id,
          balance: entry.account.balance,
          changed_at: transfer.created_at.iso8601
        )
      end

      _send_events.call(events:)
    end
  end
end
