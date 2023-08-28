module Tasks
  class StoreV1
    def initialize(store: Store.new)
      @_store = store
    end

    # @param public_id [String]
    # @param description [String]
    # @param assignee_public_id [String]
    # @param assignment_fee [Integer]
    # @param completion_reward [Integer]
    #
    # @return [Task]
    #
    def call(public_id:, **attributes)
      _store.call(public_id:, **normalize(attributes))
    end

    private

    attr_reader :_store

    def normalize(attributes)
      # We ignore assignment_fee & completion_reward from the event cause
      # its now our responsibility to set those prices, not external
      #
      attributes.delete(:assignment_fee)
      attributes.delete(:completion_reward)

      # V2 of the event has title & jira_id instead of a description
      description = attributes.delete(:description)

      title_and_jira_id = description
        .match(/^(\[(?<jira_id>[^\]]+)\] )?(?<title>.+)$/)
        .named_captures
        .symbolize_keys

      attributes.merge(title_and_jira_id)
    end
  end
end
