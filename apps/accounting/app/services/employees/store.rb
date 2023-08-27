module Employees
  class Store
    def initialize(create_account: Accounts::CreateForEmployee.new,
                   create_payment_cycle: PaymentCycles::Switch.new)
      @_create_account = create_account
      @_create_payment_cycle = create_payment_cycle
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
        ensure_payment_cycle(employee) if employee.developer?
      end

      employee
    rescue ActiveRecord::RecordNotUnique
      retry
    end

    private

    attr_reader :_create_account, :_create_payment_cycle

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

    def ensure_payment_cycle(employee)
      return if employee.payment_cycles.any?

      _create_payment_cycle.call(employee:)
    end
  end
end
