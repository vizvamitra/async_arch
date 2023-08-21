module Dimensions
  module Employees
    class Store
      # @param public_id [String]
      # @param role [String]
      # @param email [String]
      # @param first_name [String]
      # @param last_name [String]
      #
      # @return [Dimensions::Employee]
      #
      def call(public_id:, **attributes)
        employee = Dimensions::Employee.find_or_initialize_by(public_id:)
        sync(employee, attributes)

        employee
      end

      private

      def sync(employee, attributes)
        employee.update!(
          email: attributes[:email] || employee.email,
          role: attributes[:role] || employee.role,
          first_name: attributes[:first_name] || employee.first_name,
          last_name: attributes[:last_name] || employee.last_name
        )
      end
    end
  end
end
