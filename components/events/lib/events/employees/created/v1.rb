module Events
  module Employees
    module Created
      class V1 < Event
        event_type "employees/created"
        event_name "EmployeeCreated"
        event_version 1

        attribute :public_id, Types::String
        attribute :email, Types::String
        attribute :role, Types::String
        attribute :first_name, Types::String
        attribute :last_name, Types::String
        attribute :created_at, Types::String
      end
    end
  end
end
