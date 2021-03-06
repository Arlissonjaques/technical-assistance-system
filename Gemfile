# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.3', '>= 6.1.3.2'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  # RSpec for Rails 5+. Read more: https://github.com/rspec/rspec-rails
  gem 'rspec-rails', '~> 5.0.0'
  # Simple one-liner tests for common Rails functionality. Read more: https://github.com/thoughtbot/shoulda-matchers
  gem 'shoulda-matchers', '~> 4.0'
  # Annotate Rails classes with schema and routes info. Read more: https://github.com/ctran/annotate_models
  gem 'annotate'
  # A Ruby code quality reporter. Read more: https://github.com/whitesmith/rubycritic
  gem 'rubycritic', require: false
  # Code coverage for Ruby with a powerful configuration library. Read more: https://github.com/simplecov-ruby/simplecov
  gem 'simplecov', require: false
  # factories. Read more: https://github.com/thoughtbot/factory_bot_rails
  gem 'factory_bot_rails'
  # A library for generating fake data such as names, addresses, and phone numbers. Read more: https://github.com/faker-ruby/faker
  gem 'faker'
  # Generates Brazilian CPF numbers for use in testing.
  gem 'cpf_faker'
  # A runtime developer console and IRB alternative with powerful introspection capabilities.
  gem 'pry'
end

group :development do
  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
# CPF validation for ActiveModel. Read more: https://rubygems.org/gems/cpf_validator
gem 'cpf_validator'
# Token based authentication for Rails JSON APIs. Read more: https://github.com/lynndylanhurley/devise_token_auth
gem 'devise_token_auth'
# ActiveModel::Serializer implementation and Rails hooks
gem 'active_model_serializers'