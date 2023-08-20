module Events
  class SendBatch
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

    # @param events [Array<Events::Event>]
    # @return [void]
    #
    def call(events:)
      batch = prepare_batch(events)
      produce(batch)
    end

    private

    attr_reader :_infer_topic_name, :_validate, :producer, :logger

    def prepare_batch(events)
      events.map do |event|
        payload = event.payload
        topic = topic_name(event)

        case validate(payload, event.class.schema_path)
        in Success(payload)
          { topic:, payload: payload.to_json }
        in Failure(errors)
          raise EventPayloadInvalidError, errors.join(", ")
        end
      end
    end

    def topic_name(event)
      _infer_topic_name.call(event:)
    end

    def validate(payload, schema_path)
      _validate.call(payload:, schema_path:)
    end

    # TODO: handle kafka failures with some kind of retry mechanism
    #
    def produce(batch)
      batch.each do |item|
        logger.debug "[Events] Producing event into `#{item[:topic]}` topic: #{item[:payload]}"
      end

      producer.produce_many_sync(batch)
    end
  end
end
