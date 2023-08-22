module Accounts
  class Create
    CREDIT_BALANCE_CATEGORIES = %i[liability equity revenue temporary]

    def initialize(send_event: Events::Send.new)
      @_send_event = send_event
    end

    # @param name [String]
    # @param category [String]
    # @param number [Integer]
    # @param contra [Boolean]
    #
    # @return [Account]
    #
    def call(name:, category:, number:, contra: false, owner: nil)
      account = create_account(owner, name, category, number, contra)
      publish_event(account.reload)
    end

    private

    attr_reader :_send_event

    def create_account(owner, name, category, number, contra)
      Account.create!(
        owner:,
        name:,
        category:,
        number:,
        natural_balance: natural_balance(category),
        contra: contra ? :contra : :non_contra
      )
    end

    def natural_balance(category)
      "#{CREDIT_BALANCE_CATEGORIES.include?(category.to_sym) ? :credit : :debit }_balance"
    end

    def publish_event(account)
      event = Events::Accounts::Created::V2.new(
        public_id: account.public_id,
        owner_public_id: account.owner&.public_id,
        number: account.number,
        category: account.category,
        name: account.name,
        contra: account.contra?,
        created_at: account.created_at.iso8601,
      )

      _send_event.call(event:)
    end
  end
end
