class TasksController < ApplicationController
  before_action :authenticate_user!

  def index
    @tasks = Task.order(created_at: :desc)
    @tasks = @tasks.where(assignee: current_user) if params[:assigned]
  end

  def create
    Tasks::Create.new.call(**create_params.to_h.symbolize_keys)
    redirect_to tasks_path
  end

  def reassign
    result = Tasks::Reassign.new.call(user_id: current_user.id)

    case result
    when Success, Failure
      # No UI for failure handling yet
      redirect_to tasks_path
    end
  end

  private

  def create_params
    params.require(:task).permit(:title, :description)
  end
end
