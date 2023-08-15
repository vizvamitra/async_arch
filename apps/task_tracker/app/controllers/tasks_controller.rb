class TasksController < ApplicationController
  before_action :authenticate_user!

  def index
    @tasks = Task.order(status: :asc, created_at: :desc)
    @tasks = @tasks.where(assignee: current_user) if params[:assigned]
  end

  def create
    Tasks::Create.new.call(**create_params.to_h.symbolize_keys)
    redirect_to tasks_path
  end

  private

  def create_params
    params.require(:task).permit(:description)
  end
end
