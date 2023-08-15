module Events
  class Event < Dry::Struct
    def topic
      self.class.topic
    end

    def payload
      {
        type: self.class.name.demodulize,
        data: to_h
      }
    end

    class << self
      def topic(topic_name = nil)
        topic_name ? @topic = topic_name : @topic
      end
    end
  end
end
