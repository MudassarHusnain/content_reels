class ReelsController < ApplicationController
  before_action :authenticate_user!, :load_data
  before_action :set_reel, only: %i[ show edit update destroy script editor ]

  def index
    @project = Project.find(params[:project_id])
    @reels = @project.reels.all
  end

  def show
  end

  def edit
  end

  def new
    @project = Project.find(params[:project_id])
    @reel = @project.reels.new
  end

  def create
    @reel = Reel.new(reel_params)
    chat = ChatService.new(content: @reel.video_set)
    @reel.script = chat.chat_data
    respond_to do |format|
      if @reel.save
        format.html { redirect_to projects_url, notice: "Reel was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    @reel = Reel.find(params[:id])
    @reel.update(reel_param)
    respond_to do |format|
      format.js { render nothing: true }
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    respond_to do |format|
      if @reel.destroy
        format.html { redirect_to reels_path(product_id: @reel.project_id), notice: "Project was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  end

  def script
    # @reel = Reel.find(params[:id])
  end

  def editor
    @templates = @reel.templates.all
  end

  def text_to_video
    @reel = Reel.find_by(id: params[:reel_id])
    @templates = @reel.templates.last
    script = params[:script_text]
    shots = ShotstackService.new

    audio_src = rails_blob_url(@templates.file, disposition: :inline)

    id = shots.text_to_video(script, audio_src)
    api_client = Shotstack::EditApi.new
    # for now callback is not working
    sleep(20)

    @result = api_client.get_render(id, { data: false, merged: true }).response

    # payload = JSON.parse(request.body.read)
    # video_url = payload['response']['video']['url']
    # # Handle the video URL, e.g., store it, display it, etc.
    # head :ok

  end

  private

  def set_reel
    @reel = Reel.find(params[:id])
  end

  def reel_param
    params.require(:reel).permit(:script)
  end

  def reel_params
    params.require(:reel).permit(:video_set, :keywords, :no_of_video, :platform, :cta, :project_id)
  end

  def load_data
    response = HTTParty.get("https://api.elevenlabs.io/v1/voices")
    @voices = response.parsed_response["voices"]
  end
end
