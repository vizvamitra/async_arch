module Events
  class Send
    def initialize(client: producer)
      @client = client
    end

    # @param event [Events::Event]
    # @return [void]
    #
    def call(event:)
      client.produce_sync(topic: event.topic, payload: event.payload.to_json)
    end

    private

    attr_reader :client

    def producer
      WaterDrop::Producer.new do |config|
        config.kafka = { 'bootstrap.servers': 'localhost:9092' }
      end
    end
  end
end
