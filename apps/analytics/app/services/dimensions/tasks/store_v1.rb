module Dimensions
  module Tasks
    class StoreV1
      def initialize(store: Store.new)
        @_store = store
      end

      # @param public_id [String]
      # @param description [String]
      #
      # @return [Dimensions::Task]
      #
      def call(public_id:, **attributes)
        _store.call(public_id, **normalize(attributes))
      end

      private

      attr_reader :_store

      def normalize(attributes)
        description = attributes.delete(:description)

        title_and_jira_id = description
          .match(/^(\[(?<jira_id>[^\]]+)\] )?(?<title>.+)$/)
          .named_captures
          .symbolize_keys

        attributes.merge(title_and_jira_id)
      end
    end
  end
end
