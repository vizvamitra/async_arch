module Facts
  module TaskCompletionRewardFailed
    class Store
      def initialize(store_task: Dimensions::Tasks::Store.new,
                     store_employee: Dimensions::Employees::Store.new,
                     store_date: Dimensions::Dates::Store.new)
        @_store_task = store_task
        @_store_employee = store_employee
        @_store_date = store_date
      end

      # @param task_public_id [String]
      # @param employee_public_id [String]
      # @param amount [Integer]
      # @param paid_at [String]
      #
      # @return [Facts::TaskCompletionRewardFailedFact]
      #
      def call(task_public_id:, employee_public_id:, amount:, paid_at:)
        TaskCompletionRewardFailedFact.create!(
          date: find_date(DateTime.parse(paid_at)),
          task: find_task(task_public_id),
          employee: (find_employee(employee_public_id) if employee_public_id),
          amount:
        )
      end

      private

      attr_reader :_store_task, :_store_employee, :_store_date

      def find_task(public_id)
        _store_task.call(public_id:)
      end

      def find_employee(public_id)
        _store_employee.call(public_id:)
      end

      def find_date(timestamp)
        _store_date.call(timestamp:)
      end
    end
  end
end
