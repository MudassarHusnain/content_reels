class ReelsController < ApplicationController
  before_action :authenticate_user!, :load_data
  before_action :set_reel, only: [:show, :edit, :update, :destroy, :script, :editor]

  def index
    @project = Project.find(params[:project_id])
    @reels = @project.reels.all
  end

  def new
    @project = Project.find(params[:project_id])
    @reel = @project.reels.new
  end

  def create
    @reel = Reel.new(reel_params)
    chat = ChatService.new(content: @reel.video_set)
    @reel.script = chat.chat_data

    if @reel.save
      redirect_to projects_url, notice: "Reel was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @reel.update(reel_params)
    respond_to { |format| format.js { render nothing: true } }
    redirect_back(fallback_location: root_path)
  end

  def destroy
    if @reel.destroy
      redirect_to reels_path(product_id: @reel.project_id), notice: "Project was successfully destroyed."
    end
  end

  def editor
    @templates = @reel.templates.all
  end

  def text_to_video
    @video_url_data = session[:video_data_url]
    fb_token = current_user.facebook_token
    fetch_data = FacebookService.new({token: fb_token})
    @data = fetch_data.facebook_call(fb_token)

    @reel = Reel.find_by(id: params[:reel_id])
    @templates = @reel.templates.last
    script = params[:script_text]
    shots = ShotstackService.new
    audio_src = rails_blob_url(@templates.file, disposition: :inline)
    id = shots.text_to_video(script, audio_src,@video_url_data )
    api_client = Shotstack::EditApi.new
    sleep(30)
    @result = api_client.get_render(id, { data: false, merged: true }).response
    @reel.url = @result.url
    @reel.save
  end

  def fetch_url
    session[:image_data_url] = params[:image_data_Url]
    session[:video_data_url] = params[:video_data_Url]
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
