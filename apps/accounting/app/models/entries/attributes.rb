module Entries
  class Attributes < Dry::Struct
    attribute :side, Types::Symbol.enum(:debit, :credit)
    attribute :amount, Types::Integer
    attribute :account, Types::Instance(Account)

    def debit?
      side == :debit
    end

    def credit?
      side == :credit
    end
  end
end
