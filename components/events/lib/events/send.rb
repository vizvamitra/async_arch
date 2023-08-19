module Events
  class Send
    include Dry::Monads[:result]

    def initialize(infer_topic_name: InferTopicName.new,
                   validate: ValidatePayload.new,
                   producer: Events.config.producer,
                   logger: Events.config.logger)
      @_infer_topic_name = infer_topic_name
      @_validate = validate
      @producer = producer
      @logger = logger
    end

    # @param event [Events::Event]
    #
    # @return [void]
    # @raise [Events::EventSchemaNotFoundError]
    # @raise [Events::EventSchemaError]
    # @raise [Events::EventPayloadInvalidError]
    # @raise [Events::TopicNotConfiguredError]
    #
    def call(event:)
      payload = event.payload
      topic = topic_name(event)

      result = validate(payload, event.class.schema_path)

      case result
      in Success(payload)
        produce(topic, payload.to_json)
      in Failure(errors)
        raise EventPayloadInvalidError, errors.join(", ")
      end
    end

    private

    attr_reader :_validate, :_infer_topic_name, :producer, :logger

    def topic_name(event)
      _infer_topic_name.call(event:)
    end

    def validate(payload, schema_path)
      _validate.call(payload:, schema_path:)
    end

    def produce(topic, payload)
      logger.debug "[Events] Producing event into `#{topic}` topic: #{payload}"
      producer.produce_sync(topic:, payload: payload)
    end
  end
end
