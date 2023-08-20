module Tasks
  class RewardCompletion
    DESCRIPTION = "Task completion reward"

    def initialize(store_employee: Employees::Store.new,
                   store_task: Tasks::Store.new,
                   create_transfer: Transfers::Create.new)
      @_store_employee = store_employee
      @_store_task = store_task
      @_create_transfer = create_transfer
    end

    # @param task_public_id [String]
    # @param assignee_public_id [String]
    #
    # @return [Transaction]
    #
    def call(task_public_id:, assignee_public_id:)
      task = find_task(task_public_id)

      employee_account = find_employee(assignee_public_id).account
      expense_account = Account.task_completion_expense

      entries = build_entries(task, employee_account, expense_account)
      create_transfer(task, entries)
    end

    private

    attr_reader :_store_employee, :_store_task, :_create_transfer

    def find_task(public_id)
      _store_task.call(public_id:)
    end

    def find_employee(public_id)
      _store_employee.call(public_id:)
    end

    def build_entries(task, employee_account, expense_account)
      [
        build_entry(:debit, expense_account, task.completion_reward),
        build_entry(:credit, employee_account, task.completion_reward),
      ]
    end

    def create_transfer(task, entries)
      _create_transfer.call(
        entries:,
        description: DESCRIPTION,
        reference: task
      )
    end

    def build_entry(side, account, amount)
      Entries::Attributes.new(side:, account:, amount:)
    end
  end
end
