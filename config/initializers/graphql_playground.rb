# frozen_string_literal: true

# config/initializers/graphql_playground.rb
# All config options have a default that sould work out of the box
GraphqlPlayground::Rails.configure do |config|
  config.headers = {
    'X-Auth-Header' => ->(_view_context) { '123' }
  }
  config.title = 'Oly GraphQL Playground'
  config.csrf = true
  config.playground_version = 'latest'

  # see: https://github.com/prisma-labs/graphql-playground#settings
  config.settings = {
    "schema.polling.enable": false
  }
end
