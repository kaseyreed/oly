# frozen_string_literal: true

Rails.application.routes.draw do
  mount Quilt::Engine, at: '/'
  mount GraphqlPlayground::Rails::Engine, at: '/graphiql', graphql_path: '/graphql' if Rails.env.development?

  post '/graphql', to: 'graphql#execute'

  post '/webhooks/email', to: 'email_webhook#handle'
  get '/404' => 'errors#not_found'
  get '/500' => 'errors#internal_server_error'
end
