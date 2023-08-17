# frozen_string_literal: true

Doorkeeper.configure do
  orm :active_record

  resource_owner_authenticator do
    current_employee || warden.authenticate!(scope: :employee)
  end

  admin_authenticator do
    employee = current_employee || warden.authenticate!(scope: :employee)
    employee.admin?
  end
end
