module Tasks
  class ReassignmentsController < ApplicationController
    before_action :authenticate_user!

    def create
      result = Tasks::Reassign.new.call(user_id: current_user.id)

      case result
      when Success, Failure
        # No UI for failure handling yet
        redirect_to tasks_path
      end
    end
  end
end
