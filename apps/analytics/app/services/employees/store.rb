module Employees
  class Store
    def initialize(store_employee_dimension: Dimensions::Employees::Store.new)
      @_store_employee_dimension = store_employee_dimension
    end

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

      store_employee_dimension(public_id, attributes)

      employee
    rescue ActiveRecord::RecordNotUnique
      retry
    end

    private

    attr_reader :_store_employee_dimension

    def sync(employee, attributes)
      employee.update!(
        email: attributes[:email] || employee.email,
        role: attributes[:role] || employee.role,
        first_name: attributes[:first_name] || employee.first_name,
        last_name: attributes[:last_name] || employee.last_name
      )
    end

    def store_employee_dimension(public_id, attributes)
      _store_employee_dimension.call(public_id:, **attributes)
    end
  end
end
