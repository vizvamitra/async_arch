class Entry < ApplicationRecord
  enum side: { debit: 1, credit: -1 }

  belongs_to :transfer, inverse_of: :entries
  belongs_to :account, inverse_of: :entries

  validates :amount, :side, presence: true
end
