Rails.application.config.after_initialize do
  Events.configure do |config|
    config.producer_name = ENV["PRODUCER_NAME"]
    config.schema_registry_path = ENV["SCHEMA_REGISTRY_PATH"]
    config.producer = Karafka.producer
    config.logger = Rails.logger
    config.topic_mapping = {
      'accounts/created' => 'accounts.streaming',
      'accounts/balance_changed' => 'accounts'
    }
  end
end
