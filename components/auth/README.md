# Auth

SSO client engine for our services

## Installation

1. Add the gem to your `Gemfile`:

```ruby
gem 'auth', path: '../../components/auth'
```

```bash
bundle install
```

2. Copy migrations:

```bash
rails auth:install:migrations
rails db:migrate
```

3. Set up routes:

```ruby
# config/routes.rb

Rails.application.routes.draw do
  mount Auth::Engine, at: "/"
  # ...
end
```

4. Configure the engine:

```ruby
# config/initializers/auth.rb

Rails.application.config.after_initialize do
  Auth.configure do |config|
    config.after_sign_in_path = "/"
    config.after_sign_out_path = "/"
    config.on_new_identity = proc do |identity:, info:|
      # Your code here
    end
  end
end
```

## Usage

Use `current_identity` method to get the identity user is signed in with.

Add Sign In / Sign Out buttons for your views:

```ruby
button_to(
  "Sign in",
  auth.identity_doorkeeper_omniauth_authorize_path,
  method: :post,
  data: { turbo: false }
)

link_to(
  "Sign out",
  auth.destroy_identity_session_path,
  data: { "turbo-method": :delete }
)
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
