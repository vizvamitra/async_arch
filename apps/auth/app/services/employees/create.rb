module Employees
  class Create
    include Dry::Monads[:result]

    def initialize(send_event: Events::Send.new)
      @send_event = send_event
    end

    # @param attributes [Hash]
    # @option attributes [String] :email
    # @option attributes [String] :password
    # @option attributes [String] :password_confirmation
    # @option attributes [String] :first_name
    # @option attributes [String] :last_name
    # @option attributes [String] :role
    #
    # @return [Success<Employee>, Failure<Hash>]
    # @raise [KeyError]
    #
    def call(**attributes)
      employee = create_employee(attributes)
      return Failure(employee) unless employee.valid?

      publish_event(employee)

      Success(employee)
    end

    private

    attr_reader :send_event

    def create_employee(attributes)
      Employee.create(
        email: attributes.fetch(:email),
        password: attributes.fetch(:password),
        password_confirmation: attributes.fetch(:password_confirmation),
        public_id: SecureRandom.uuid,
        role: attributes.fetch(:role),
        first_name: attributes.fetch(:first_name),
        last_name: attributes.fetch(:last_name)
      )
    end

    def publish_event(employee)
      event = Events::Streaming::EmployeeCreated.new(
        public_id: employee.public_id,
        email: employee.email,
        role: employee.role,
        first_name: employee.first_name,
        last_name: employee.last_name,
        created_at: employee.created_at.to_i
      )

      send_event.call(event:)
    end
  end
end
