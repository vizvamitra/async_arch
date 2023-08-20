# frozen_string_literal: true

class KarafkaApp < Karafka::App
  setup do |config|
    config.kafka = { 'bootstrap.servers': ENV['KAFKA_HOST'] }
    config.client_id = ENV['PRODUCER_NAME']
    config.consumer_persistence = !Rails.env.development?
  end

  # Karafka.monitor.subscribe(Karafka::Instrumentation::LoggerListener.new)
  # Karafka.monitor.subscribe(Karafka::Instrumentation::ProctitleListener.new)

  Karafka.producer.monitor.subscribe(
    WaterDrop::Instrumentation::LoggerListener.new(
      Karafka.logger,
      log_messages: false
    )
  )

  routes.draw do
    # active_job_topic :default
    topic :"employees.streaming" do
      consumer EmployeesConsumer
    end
    topic :"tasks.streaming" do
      consumer TasksConsumer
    end
    topic :"task_lifecycle" do
      consumer TasksConsumer
    end
  end
end
