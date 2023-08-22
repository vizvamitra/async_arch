module Employees
  class Store
    def initialize(create_account: Accounts::CreateForEmployee.new)
      @_create_account = create_account
    end

    # @param public_id [String]
    # @param email [String]
    # @param role [String]
    # @param first_name [String]
    # @param last_name [String]
    #
    # @return [Employee]
    #
    def call(public_id:, **attributes)
      employee = Employee.find_or_initialize_by(public_id:)

      ActiveRecord::Base.transaction do
        sync(employee, attributes)
        create_account(employee) if employee.account.nil?
      end

      employee
    rescue ActiveRecord::RecordNotUnique
      retry
    end

    private

    attr_reader :_create_account

    def sync(employee, attributes)
      employee.update!(
        email: attributes[:email] || employee.email,
        role: attributes[:role] || employee.role,
        first_name: attributes[:first_name] || employee.first_name,
        last_name: attributes[:last_name] || employee.last_name
      )
    end

    def create_account(employee)
      _create_account.call(employee:)
    end
  end
end
