module Events
  class ValidatePayload
    include Dry::Monads[:result]

    def initialize(schema_registry_path: Events.config.schema_registry_path)
      @schema_registry_path = schema_registry_path
    end

    # @param payload [Hash]
    # @param schema_path [String]
    #
    # @return [Success<payload>, Failure<errors>]
    # @raise [Events::EventSchemaNotFoundError]
    # @raise [Events::EventSchemaInvalidError]
    #
    def call(payload:, schema_path:)
      schema = Pathname.new(schema_registry_path).join(schema_path)
      raise EventSchemaNotFoundError unless schema.exist?

      payload = payload.as_json
      errors = validator(schema).validate(payload)

      errors.none? ? Success(payload) : Failure(humanize(errors))
    end

    private

    attr_reader :schema_registry_path

    def validator(schema)
      JSONSchemer.schema(schema)
    rescue => e
      raise EventSchemaInvalidError, e.message, e.backtrace
    end

    def humanize(errors)
      errors.map { |error| JSONSchemer::Errors.pretty(error) }
    end
  end
end
