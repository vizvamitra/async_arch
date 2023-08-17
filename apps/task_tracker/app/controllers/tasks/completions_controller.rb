module Tasks
  class CompletionsController < ApplicationController
    before_action :authenticate_identity!

    def create
      result = Tasks::Complete.new.call(
        identity_id: current_identity.id,
        task_id: params[:task_id]
      )

      case result
      when Success, Failure
        # No UI for failure handling yet
        redirect_to tasks_path
      end
    end
  end
end
