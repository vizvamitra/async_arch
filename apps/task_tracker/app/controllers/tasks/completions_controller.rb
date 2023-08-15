module Tasks
  class CompletionsController < ApplicationController
    before_action :authenticate_user!

    def create
      result = Tasks::Complete.new.call(
        user_id: current_user.id,
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
