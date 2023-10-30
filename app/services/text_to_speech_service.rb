# app/services/text_to_speech_service.rb
require "httparty"
# API_KEY = Rails.application.credentials[:text_api_key]

class TextToSpeechService
  # TEXT_API_KEY = Rails.application.credentials[:text_api_key]

  def initialize(text, voice_type)
    @text = text
    @voice_type = voice_type
  end

  def call
    endpoint = "https://api.elevenlabs.io/v1/text-to-speech/#{@voice_type}"
    headers = {
      "Content-Type" => "application/json",
      "xi-api-key" => TEXT_API_KEY,
    }
    accept = "audio/mp3"
    body = {
      text: @text,
      accept: accept,
    }

    HTTParty.post(endpoint, headers: headers, body: body.to_json)
  end
end
