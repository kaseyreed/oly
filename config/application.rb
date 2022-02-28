# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Oly
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    config.time_zone = 'Central Time (US & Canada)'
    # config.eager_load_paths << Rails.root.join("extras")

    config.exceptions_app = routes

    # cors policy
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins 'kaseyreed-oly-*.githubpreview.dev'
        resource 'graphql', :headers => :any, :methods => [:post, :options]
      end
    end
  end
end
