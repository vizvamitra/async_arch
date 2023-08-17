class ApplicationController < ActionController::Base
  include Dry::Monads[:result]

  def current_employee
    Employee.find_by!(identity: current_identity)
  end
  helper_method :current_employee
end
