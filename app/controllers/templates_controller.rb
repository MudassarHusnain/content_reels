class TemplatesController < ApplicationController
  before_action :set_reel, only: [:new, :create]

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
      respond_to do |format|
        if @template.save
          format.html { redirect_to request.referer, notice: "Audio was successfully Created." }
        else
          render "new"
        end
      end
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
    respond_to do |format|
      if @template.save
        format.html { redirect_to request.referer, notice: "Audio was successfully Created." }
      else
        render "new"
      end
    end
  end

  def image_search
    image = PexelService.new(image: params[:image_text])
    @image_url = image.generate_images
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace('show_data', partial: 'templates/image_show', :locals => { :show_images => @image_url }) }
    end
  end

  def video_search
    video = PexelService.new(video: params[:video_text])
    @video_url = video.generate_videos
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace('show_data', partial: 'templates/image_show', :locals => { :show_video => @video_url }) }
    end
  end

  def fetch_url
    @arr=[]
    if session[:videos_url].nil?
      @arr << params[:url]
    else
      @arr=session[:videos_url]
    end
    @arr << params[:url]
    session[:videos_url]=@arr
    @video_url = params[:video_url]
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace('show_data', partial: 'templates/image_show', :locals => { :show_video => @video_url }) }
    end
  end

  private

  def set_reel
    @reel = Reel.find_by(id: params[:reel_id])
  end

  def template_params
    params.require(:template).permit(:file, :reel_id)
  end
end
