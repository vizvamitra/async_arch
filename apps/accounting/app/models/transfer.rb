class Transfer < ApplicationRecord
  has_many :entries, inverse_of: :transfer
  belongs_to :reference, polymorphic: true

  validates :date, :description, presence: true
end
