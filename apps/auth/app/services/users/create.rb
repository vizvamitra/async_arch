module Users
  class Create
    include Dry::Monads[:result]

    def initialize(send_event: SendEvent.new)
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
    # @return [Success<User>, Failure<Hash>]
    # @raise [KeyError]
    #
    def call(**attributes)
      user = create_user(attributes)
      return Failure(user.errors.messages) unless user.valid?

      publish_event(user)

      Success(user)
    end

    private

    attr_reader :send_event

    def create_user(attributes)
      User.create(
        email: attributes.fetch(:email),
        password: attributes.fetch(:password),
        password_confirmation: attributes.fetch(:password_confirmation),
        public_id: SecureRandom.uuid,
        role: attributes.fetch(:role),
        first_name: attributes.fetch(:first_name),
        last_name: attributes.fetch(:last_name)
      )
    end

    def publish_event(user)
      event = Events::UserCreated.new(
        public_id: user.public_id,
        email: user.email,
        role: user.role,
        first_name: user.first_name,
        last_name: user.last_name,
        created_at: user.created_at.to_i
      )

      send_event.call(event:)
    end
  end
end
