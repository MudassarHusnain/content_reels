require "shotstack"
Shotstack.configure do |config|
  config.api_key['x-api-key'] = Rails.application.credentials.dig(:shot_stack, :key)
  config.host = Rails.application.credentials.dig(:shot_stack, :host)
  config.base_path = Rails.application.credentials.dig(:shot_stack, :base_path)
end
