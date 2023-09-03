module Tasks
  class HandleAssignment
    def initialize(store_employee: Employees::Store.new,
                   store_task: Tasks::Store.new,
                   charge: Operations::ChargeTaskAssignmentFee.new)
      @_store_employee = store_employee
      @_store_task = store_task
      @_charge = charge
    end

    # @param task_public_id [String]
    # @param assignee_public_id [String]
    #
    # @return [Transaction]
    #
    def call(task_public_id:, assignee_public_id:)
      task = find_task(task_public_id)
      account = find_employee(assignee_public_id).account

      charge(account, task.assignment_fee, task)
    end

    private

    attr_reader :_store_employee, :_store_task, :_charge

    def find_task(public_id)
      _store_task.call(public_id:)
    end

    def find_employee(public_id)
      _store_employee.call(public_id:)
    end

    def charge(account, amount, reference)
      _charge.call(account:, amount:, reference:)
    end
  end
end
