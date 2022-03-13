Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'kaseyreed-oly-*.githubpreview.dev'
    resource 'graphql', :headers => :any, :methods => [:post, :options]
  end
end
