class TextToSpeechController < ApplicationController
  before_action :load_data
  def index
  end

  def text_to_speech
    service = TextToSpeechService.new(params[:text], params[:voice])
    begin
      file_path = service.call
      send_file file_path, type: 'audio/mp3', disposition: 'inline'
    rescue StandardError => e
      render plain: 'Error: ' + e.error_message, status: :unprocessable_entity
    end
  end

  private
  def load_data
    response = HTTParty.get("https://api.elevenlabs.io/v1/voices")
    @voices = response.parsed_response["voices"]
  end
end





