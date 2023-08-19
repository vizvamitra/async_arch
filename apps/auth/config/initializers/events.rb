Rails.application.config.after_initialize do
  Events.configure do |config|
    config.producer_name = ENV["PRODUCER_NAME"]
    config.schema_registry_path = ENV["SCHEMA_REGISTRY_PATH"]
    config.producer = WaterDrop::Producer.new do |config|
      config.kafka = { 'bootstrap.servers': ENV["KAFKA_HOST"] }
    end
    config.logger = Rails.logger
    config.topic_mapping = {
      'employees/created' => 'employees.streaming',
    }
  end
end
