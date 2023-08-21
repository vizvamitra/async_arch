module Facts
  module AccountBalanceChanged
    class Store
      def initialize(store_employee: Dimensions::Employees::Store.new,
                     store_account: Dimensions::Accounts::Store.new,
                     store_date: Dimensions::Dates::Store.new)
        @_store_employee = store_employee
        @_store_account = store_account
        @_store_date = store_date
      end

      # @param account_public_id [String]
      # @param owner_public_id [String]
      # @param balance [Integer]
      # @param changed_at [String]
      #
      # @return [Facts::AccountBalanceChangedFact]
      #
      def call(account_public_id:, owner_public_id:, balance:, changed_at:)
        AccountBalanceChangedFact.create(
          date: find_date(DateTime.parse(changed_at)),
          employee: (find_employee(owner_public_id) if owner_public_id),
          account: find_account(account_public_id),
          balance:
        )
      end

      private

      attr_reader :_store_employee, :_store_account, :_store_date

      def find_employee(public_id)
        _store_employee.call(public_id:)
      end

      def find_account(public_id)
        _store_account.call(public_id:)
      end

      def find_date(timestamp)
        _store_date.call(timestamp:)
      end
    end
  end
end
