class DashboardController < ApplicationController
  before_action :authenticate_identity!

  def show
    if current_employee.accountant? || current_employee.admin?
      @system_accounts = Account.where.not(number: [
        Accounts::Numbers::EMPLOYEE,
        Accounts::Numbers::INCOME_SUMMARY
      ])
    end

    @employee_account = current_employee.account
    @entries = @employee_account.entries.order(created_at: :desc).includes(:transfer)
  end
end
