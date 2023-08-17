module Employees
  class Store
    # @param public_id [String]
    # @param email [String]
    # @param role [String]
    # @param first_name [String]
    # @param last_name [String]
    #
    # @return [Employee]
    # @raise [KeyError]
    #
    def call(public_id:, **attributes)
      employee = Employee.find_or_initialize_by(public_id:)
      sync(employee, attributes)

      employee
    rescue ActiveRecord::RecordNotUnique
      retry
    end

    private

    def sync(employee, attributes)
      employee.update!(
        email: attributes.fetch(:email),
        role: attributes.fetch(:role),
        first_name: attributes.fetch(:first_name),
        last_name: attributes.fetch(:last_name)
      )
    end
  end
end
