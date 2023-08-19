# frozen_string_literal: true

require "waterdrop"
require "dry-struct"
require "dry-monads"
require "json_schemer"
require "json"

require_relative "events/version"

module Events
  Error = Class.new(StandardError)
  EventSchemaNotFoundError = Class.new(Error)
  EventSchemaInvalidError = Class.new(Error)
  EventPayloadInvalidError = Class.new(Error)
  TopicNotConfiguredError = Class.new(Error)
  MisconfigurationError = Class.new(Error)

  Types = Dry.Types()

  class Configuration
    def initialize
      @topic_mapping = {}
    end

    attr_accessor :producer, :producer_name, :schema_registry_path,
                  :topic_mapping, :logger

    def valid?
      producer && producer_name && schema_registry_path && logger
    end
  end

  class << self
    attr_reader :config

    def configure
      @config = Configuration.new
      yield config

      return if config.valid?

      raise MisconfigurationError, <<~MSG
        Your configuration is incomplete. For producing to work, you need to configure at least the following:

          Rails.application.config.after_initialize do
            Events.configure do |config|
              # This is used in the event payload
              config.producer_name = "my_producer"

              # This is needed for event validation
              config.schema_registry_path = "../../schema_registry"

              # This should be a preconfigured WaterDrop::Producer
              config.producer = Karafka.producer

              # For logging, ya know
              config.logger = Rails.logger

              # This is needed for producing code to know, into which topic your
              # event should be pushed
              #
              config.topic_mapping = {
                # Event type       | Topic name
                'tasks/created'   => 'tasks.streaming',
                'tasks/assigned'  => 'task_lifecycle',
                # ...
              }
            end
          end
      MSG
    end
  end
end

require "events/event"
Gem.find_files("events/**/*.rb").each { |path| require path }
