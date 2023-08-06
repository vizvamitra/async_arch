class ApplicationController < ActionController::Base
  before_action :verify_admin_access, if: :active_admin_controller?

  private

  def verify_admin_access
    return if current_user.admin?

    redirect_to root_path, notice: "Unauthorized!"
  end

  def active_admin_controller?
    is_a?(ActiveAdmin::BaseController)
  end
end
