class TemplatesController < ApplicationController
  before_action :set_reel, only: [:new, :create]

  def index
  end

  def new
    @template = @reel.templates.new
  end

  def create
    @template = Template.new(template_params)
    if @template.save
      redirect_to editor_reel_url(id: @template.reel_id)
    else
      render "new"
    end
  end

  def text_to_speech
    service = TextToSpeechService.new(params[:text], params[:voice])

    begin
      file_path = service.call
      filename = "#{SecureRandom.hex(8)}.mp3"

      audio_data = {
        file: {
          io: StringIO.new(file_path.body.to_s),
          filename: filename,
          content_type: "audio/mp3",
        },
      }
      @reel = Reel.find_by(id: params[:reel_id])
      @template = @reel.templates.new(audio_data)
      @template.save
    rescue StandardError => e
      render plain: "Error: " + e.error_message, status: :unprocessable_entity
    end
  end

  def show_microphone
    data = params["audio_blob"].split(",")[1]
    filename = "#{SecureRandom.hex(8)}.mp3"
    recording_data = {
      file: {
        io: StringIO.new(Base64.decode64(data)),
        filename: filename,
        content_type: "audio/mpeg",
      },
    }
    @reel = Reel.find_by(id: params[:reel_id])
    @template = @reel.templates.new(recording_data)
    @template.save
    redirect_to request.referer
  end

  def record_microphone_audio
  end

  private

  def set_reel
    @reel = Reel.find_by(id: params[:reel_id])
  end

  def template_params
    params.require(:template).permit(:file, :reel_id)
  end
end
