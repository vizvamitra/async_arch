module Dimensions
  module Accounts
    class Store
      def initialize(store_employee: Dimensions::Employees::Store.new)
        @_store_employee = store_employee
      end

      # @param public_id [String]
      # @param owner_public_id [String]
      # @param category [String]
      #
      # @return [Dimensions::Account]
      #
      def call(public_id:, **attributes)
        ActiveRecord::Base.transaction do
          store_employee(attributes[:owner_public_id]) if attributes[:owner_public_id]

          account = Account.find_or_initialize_by(public_id: public_id)
          sync(account, attributes)

          account
        end
      end

      private

      attr_reader :_store_employee

      def store_employee(public_id)
        _store_employee.call(public_id: public_id)
      end

      def sync(account, attributes)
        account.update!(
          category: attributes[:category] || account.category,
          owner_public_id: attributes[:owner_public_id] || account.owner_public_id
        )
      end
    end
  end
end
