module Tasks
  class RewardCompletion
    DESCRIPTION = "Task completion reward"

    def initialize(store_employee: Employees::Store.new,
                   store_task: Tasks::Store.new,
                   create_transfer: Transfers::Create.new,
                   send_event: Events::Send.new)
      @_store_employee = store_employee
      @_store_task = store_task
      @_create_transfer = create_transfer
      @_send_event = send_event
    end

    # @param task_public_id [String]
    # @param assignee_public_id [String]
    #
    # @return [Transaction]
    #
    def call(task_public_id:, assignee_public_id:)
      task = find_task(task_public_id)
      employee = find_employee(assignee_public_id)
      expense_account = Account.task_completion_expense

      entries = build_entries(task, employee.account, expense_account)

      ActiveRecord::Base.transaction do
        transfer = create_transfer(task, entries)
        send_event(task, employee, transfer)

        transfer
      end
    end

    private

    attr_reader :_store_employee, :_store_task, :_create_transfer, :_send_event

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

    def send_event(task, employee, transfer)
      event = Events::Transactions::TaskCompletionRewardPaid::V1.new(
        task_public_id: task.public_id,
        employee_public_id: employee.public_id,
        amount: task.completion_reward,
        paid_at: transfer.created_at.iso8601
      )

      _send_event.call(event:)
    end
  end
end
