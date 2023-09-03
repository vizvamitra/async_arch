module Tasks
  class HandleCompletion
    def initialize(store_employee: Employees::Store.new,
                   store_task: Tasks::Store.new,
                   reward: Operations::RewardTaskCompletion.new)
      @_store_employee = store_employee
      @_store_task = store_task
      @_reward = reward
    end

    # @param task_public_id [String]
    # @param assignee_public_id [String]
    #
    # @return [Transfer]
    #
    def call(task_public_id:, assignee_public_id:)
      task = find_task(task_public_id)
      account = find_employee(assignee_public_id).account

      reward(account, task.completion_reward, task)
    end

    private

    attr_reader :_store_employee, :_store_task, :_reward

    def find_task(public_id)
      _store_task.call(public_id:)
    end

    def find_employee(public_id)
      _store_employee.call(public_id:)
    end

    def reward(account, amount, reference)
      _reward.call(account:, amount:, reference:)
    end
  end
end
