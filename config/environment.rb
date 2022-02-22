# Load the Rails application.
require_relative "application"


# Use camcel case for json responses
Jbuilder.deep_format_keys true
Jbuilder.key_format camelize: :lower

# Initialize the Rails application.
Rails.application.initialize!
