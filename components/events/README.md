# Events

An event producing library that integrate ruby apps with our schema registry & message brocker.

1. Add the gem to your `Gemfile`:

```ruby
gem 'events', path: '../../components/events'
```

```bash
bundle install
```

2. Configure the library:

```ruby
# config/initializers/events.rb

Rails.application.config.after_initialize do
  Events.configure do |config|
    config.producer_name = ENV["PRODUCER_NAME"]
    config.schema_registry_path = ENV["SCHEMA_REGISTRY_PATH"]
    config.producer = Karafka.producer # or pure Waterdrop::Producer
    config.logger = Rails.logger
    config.topic_mapping = {
      # EVENT TYPE        | TOPIC NAME
      'accounts/created' => 'accounts.streaming',
      'accounts/balance_changed' => 'accounts'
    }
  end
end

```

## Usage

Send events like this:

```ruby
event = Events::Employees::Created::V1.new(...)
Events::Send.new.call(event:)

# Or, for batch sending:

events = [
  Events::Tasks::Created::V3.new(...),
  Events::Tasks::Assigned::V1.new(...)
]
Events::SendBatch.new.call(events:)
```
