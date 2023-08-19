module Events
  class Event < Dry::Struct
    attr_reader :event_id, :event_time

    def initialize(*attrs,
                   producer_name: Events.config.producer_name)
      @producer_name = producer_name

      @event_id = SecureRandom.uuid
      @event_time = Time.current

      super(*attrs)
    end

    def payload
      {
        event_id:,
        event_name: self.class.event_name,
        event_version: self.class.event_version,
        event_time: event_time.iso8601,
        producer: producer_name,
        data: to_h
      }
    end

    private

    attr_reader :producer_name

    class << self
      def event_type(type = nil)
        type ? @event_type = type : @event_type
      end

      def event_name(name = nil)
        name ? @event_name = name : @event_name
      end

      def event_version(version = nil)
        version ? @event_version = version : @event_version
      end

      def schema_path
        "#{event_type}/#{event_version}.json"
      end
    end
  end
end
