# app/services/text_to_speech_service.rb
require 'httparty'
API_KEY = Rails.application.credentials[:text_api_key]

class TextToSpeechService
  def initialize(text, voice_type)
    @text = text
    @voice_type = voice_type
  end

  def call
    endpoint = "https://api.elevenlabs.io/v1/text-to-speech/#{@voice_type}"
    headers = {
      'Content-Type' => 'application/json',
      'xi-api-key' => API_KEY
    }
    accept = 'audio/mp3'
    body = {
      text: @text,
      accept: accept
    }
    response = HTTParty.post(endpoint, headers: headers, body: body.to_json)
    if response.success?
      file_path = Rails.root.join('public', 'audio', 'hello.mp3')
      File.binwrite(file_path, response.body)
      file_path
    else
      raise StandardError.new('API Error: ' + response.body)
    end
  end
end
