require "openai"
OpenAI.configure do |config|
  config.access_token = Rails.application.credentials[:chatgpt_token]
  # config.organization_id = ENV.fetch("OPENAI_ORGANIZATION_ID") # Optional.
end
