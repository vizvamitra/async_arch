module Tasks
  class ReassignmentsController < ApplicationController
    before_action :authenticate_identity!

    def create
      result = Tasks::Reassign.new.call(identity_id: current_identity.id)

      case result
      when Success, Failure
        # No UI for failure handling yet
        redirect_to tasks_path
      end
    end
  end
end
