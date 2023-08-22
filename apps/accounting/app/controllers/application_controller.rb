class ApplicationController < ActionController::Base
  def current_employee
    Employee.find_by!(identity: current_identity)
  end
  helper_method :current_employee
end
