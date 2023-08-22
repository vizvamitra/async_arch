module Events
  class InferTopicName
    def initialize(topic_mapping: Events.config.topic_mapping)
      @topic_mapping = topic_mapping
    end

    # @param event [Events::Event]
    #
    # @return [String]
    # @raise [Events::TopicNotConfiguredError]
    #
    def call(event:)
      topic = topic_name(event)
      return topic if topic

      throw_error(event.class.event_type)
    end

    private

    attr_reader :topic_mapping

    def topic_name(event)
      topic_mapping[event.class.event_type]
    end

    def throw_error(event_type)
      raise TopicNotConfiguredError, <<~MSG
        Topic name is not configured for the event of type #{event_type}. You need to add it to your serializer:

          Rails.application.config.after_initialize do
            Events.configure do |config|
              # ...
              config.topic_mapping = {
                # ...
                "#{event_type}" => "my_topic"
              }
            end
          end
      MSG
    end
  end
end
