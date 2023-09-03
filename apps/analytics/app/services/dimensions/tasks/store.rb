module Dimensions
  module Tasks
    class Store
      # @param public_id [String]
      # @param title [String]
      # @param jira_id [String,nil]
      #
      # @return [Dimensions::Task]
      #
      def call(public_id:, **attributes)
        task = Task.find_or_initialize_by(public_id:)
        sync(task, attributes)

        task
      end

      private

      def sync(task, attributes)
        task.update!(
          title: attributes[:title] || task.title,
          jira_id: attributes[:jira_id] || task.jira_id
        )
      end
    end
  end
end
