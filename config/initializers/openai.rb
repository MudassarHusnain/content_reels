OpenAI.configure do |config|
    config.access_token = Rails.application.credentials.dig(:chat_gpt, :client_secret)
end