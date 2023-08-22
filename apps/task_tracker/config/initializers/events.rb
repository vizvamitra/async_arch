Rails.application.config.after_initialize do
  Events.configure do |config|
    config.producer_name = ENV["PRODUCER_NAME"]
    config.schema_registry_path = ENV["SCHEMA_REGISTRY_PATH"]
    config.producer = Karafka.producer
    config.logger = Rails.logger
    config.topic_mapping = {
      'tasks/created' => 'tasks.streaming',
      'tasks/assigned' => 'task_lifecycle',
      'tasks/completed' => 'task_lifecycle'
    }
  end
end
