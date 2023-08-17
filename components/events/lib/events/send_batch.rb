module Events
  class SendBatch
    def initialize(client: producer)
      @client = client
    end

    # @param events [Array<Events::Event>]
    # @return [void]
    #
    def call(events:)
      batch = events.map { |e| serialize(e) }
      client.produce_many_sync(batch)
    end

    private

    attr_reader :client

    def serialize(event)
      { topic: event.topic, payload: event.payload.to_json }
    end

    def producer
      WaterDrop::Producer.new do |config|
        config.kafka = { 'bootstrap.servers': 'localhost:9092' }
      end
    end
  end
end
