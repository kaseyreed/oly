# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Oly
  class Application < Rails::Application
    config.load_defaults 7.0
    config.api_only = true
    config.debug_exception_response_format = :api
    config.time_zone = 'Central Time (US & Canada)'

    # Set up for graphiql?
    config.session_store :cookie_store, key: '_oly_session'
    config.middleware.use ActionDispatch::Cookies # Required for all session management
    config.middleware.use config.session_store, config.session_options
  end
end
